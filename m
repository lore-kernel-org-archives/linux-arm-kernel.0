From: mmarek@suse.cz (Michal Marek)
Date: Tue, 19 Feb 2013 10:22:21 +0100
Subject: [patch 1/2] kcmp: Make it to depend on CONFIG_KCMP
In-Reply-To: <20130219065210.030802820@openvz.org>
References: <20130219064800.719149796@openvz.org>
 <20130219065210.030802820@openvz.org>
Message-ID: <5123444D.6000806@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.2.2013 07:48, Cyrill Gorcunov wrote:
> --- linux-2.6.git.orig/init/Kconfig
> +++ linux-2.6.git/init/Kconfig
> @@ -279,6 +279,15 @@ config FHANDLE
>  	  get renamed. Enables open_by_handle_at(2) and name_to_handle_at(2)
>  	  syscalls.
>  
> +config KCMP
> +	bool "kcmp syscall"
> +	default n

Previously, kcmp was enabled with CONFIG_CHECKPOINT_RESTORE. Maybe
change it to 'default CHECKPOINT_RESTORE', so that make oldconfig does
the right thing?

Michal
