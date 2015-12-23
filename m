From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 23 Dec 2015 17:15:58 +0300
Subject: [PATCH v6 04/20] arm64: change some CONFIG_COMPAT over to use
 CONFIG_AARCH32_EL0 instead
In-Reply-To: <1450215766-14765-5-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-5-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151223141558.GA22543@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 12:42:30AM +0300, Yury Norov wrote:
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -13,9 +13,8 @@
>   * You should have received a copy of the GNU General Public License
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> -#ifdef CONFIG_COMPAT
> +#ifdef CONFIG_AARCH32_EL0
>  #define __ARCH_WANT_COMPAT_SYS_GETDENTS64
> -#define __ARCH_WANT_COMPAT_STAT64
>  #define __ARCH_WANT_SYS_GETHOSTNAME
>  #define __ARCH_WANT_SYS_PAUSE
>  #define __ARCH_WANT_SYS_GETPGRP
> @@ -26,7 +25,9 @@
>  #define __ARCH_WANT_COMPAT_SYS_SENDFILE
>  #define __ARCH_WANT_SYS_FORK
>  #define __ARCH_WANT_SYS_VFORK
> +#endif
>  
> +#ifdef CONFIG_COMPAT

It seems like __NR_compat_* and __ARM_NR_compat_*
are needed by aarch32 only. If so, it should not be
defined for ilp32. And the only common definition
here would be __ARCH_WANT_COMPAT_STAT64.

>  /*
>   * Compat syscall numbers used by the AArch64 kernel.
>   */
> @@ -44,6 +45,8 @@
>  #define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE+2)
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE+5)
>  
> +#define __ARCH_WANT_COMPAT_STAT64
> +
>  #define __NR_compat_syscalls		390
>  #endif
