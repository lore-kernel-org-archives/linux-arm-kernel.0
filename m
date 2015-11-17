From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 23:07:03 +0100
Subject: [PATCH v6 15/19] arm64: ilp32: force IPC_64 in msgctl, shmctl,
 semctl
In-Reply-To: <1447795019-30176-16-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-16-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <26387039.NNJ6EnRrv8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 November 2015 00:16:55 Yury Norov wrote:
> 
> +/* IPC_64 */
> +asmlinkage long ilp32_sys_msgctl(int first, int second, void __user *uptr)
> +{
> +       return compat_sys_msgctl(first, second | IPC_64, uptr);
> +}
> +#define compat_sys_msgctl              ilp32_sys_msgctl
> +
> +asmlinkage long ilp32_sys_shmctl(int first, int second, void __user *uptr)
> +{
> +       return compat_sys_shmctl(first, second | IPC_64, uptr);
> +}
> +#define compat_sys_shmctl              ilp32_sys_shmctl
> +
> +asmlinkage long ilp32_sys_semctl(int first, int second, int third, int arg)
> +{
> +       return compat_sys_semctl(first, second, third | IPC_64, arg);
> +}
> +#define compat_sys_semctl      ilp32_sys_semctl
> 

I wonder if this would be any simpler by changing compat_ipc_parse_version()

	Arnd
