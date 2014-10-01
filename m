From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 Oct 2014 13:48:38 +0100
Subject: [PATCH 09/24] ARM64:ILP32: Use the same syscall names as LP64
In-Reply-To: <1409779158-30963-10-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
 <1409779158-30963-10-git-send-email-apinski@cavium.com>
Message-ID: <20141001124838.GJ12702@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 10:19:03PM +0100, Andrew Pinski wrote:
> Define __SYSCALL_NONCOMPAT so we use the 64bit naming scheme for ILP32.

The log doesn't match the actual patch.

> --- a/arch/arm64/include/uapi/asm/unistd.h
> +++ b/arch/arm64/include/uapi/asm/unistd.h
> @@ -13,4 +13,10 @@
>   * You should have received a copy of the GNU General Public License
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> +
> +/* For ILP32, we want to use the non compat names. */
> +#if defined(__ILP32__)
> +#define __ARCH_WANT_64BIT_SYSCALLS
> +#endif
> +
>  #include <asm-generic/unistd.h>

-- 
Catalin
