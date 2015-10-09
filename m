From: lkp@intel.com (kbuild test robot)
Date: Fri, 9 Oct 2015 14:41:19 +0800
Subject: [PATCH v3 7/7] arm64: ftrace: add arch-specific stack tracer
In-Reply-To: <1444298504-10392-8-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <201510091403.6zgr6kRc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi AKASHI,

[auto build test WARNING on v4.3-rc4 -- if it's inappropriate base, please ignore]

config: arm64-defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/process.c:53:0:
>> arch/arm64/include/asm/stacktrace.h:28:40: warning: 'struct stack_trace' declared inside parameter list
    extern void save_stack_trace_sp(struct stack_trace *trace, unsigned long *sp);
                                           ^
>> arch/arm64/include/asm/stacktrace.h:28:40: warning: its scope is only this definition or declaration, which is probably not what you want

vim +28 arch/arm64/include/asm/stacktrace.h

    12	 *
    13	 * You should have received a copy of the GNU General Public License
    14	 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
    15	 */
    16	#ifndef __ASM_STACKTRACE_H
    17	#define __ASM_STACKTRACE_H
    18	
    19	struct stackframe {
    20		unsigned long fp;
    21		unsigned long sp;
    22		unsigned long pc;
    23	};
    24	
    25	extern int unwind_frame(struct stackframe *frame);
    26	extern void walk_stackframe(struct stackframe *frame,
    27				    int (*fn)(struct stackframe *, void *), void *data);
  > 28	extern void save_stack_trace_sp(struct stack_trace *trace, unsigned long *sp);
    29	
    30	#endif	/* __ASM_STACKTRACE_H */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 16486 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151009/9176171a/attachment.obj>
