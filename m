From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 16 Feb 2016 17:37:22 -0800
Subject: [clk:clk-samsung-kconfig 1/2] drivers/clk/samsung/clk.h:29:26:
 error: field 'clk_data' has incomplete type
In-Reply-To: <56C3C9FB.8090301@samsung.com>
References: <201602170850.V9nmoMr3%fengguang.wu@intel.com>
 <56C3C9FB.8090301@samsung.com>
Message-ID: <CAEG3pNAGKRavxOC2aDGuJ4S_RU0DsjmXQiy54MTmkO=qrRE6JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 5:16 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
>
> On 17.02.2016 09:01, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-samsung-kconfig
> > head:   e83cb468452c25597e868d1ed778fa73fdaeca4c
> > commit: 89e08b1b13374a336dfd1d500ebc70aa545579ab [1/2] clk: samsung: Enable COMPILE_TEST for Samsung clocks
> > config: ia64-allmodconfig (attached as .config)
> > reproduce:
> >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 89e08b1b13374a336dfd1d500ebc70aa545579ab
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=ia64
> >
>
> I think the error is a result of missing one patch in the branch - the
> "clk: Move vendor's Kconfig into CCF menu section":
> https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=b9e65ebc654dffeb77d8ef878bd6b2da30c55a94

OK, I have rebased the clk-samsung branch on top of b9e65ebc654d. This
means the immutable branch will pull in about a dozen unrelated
patches, but I don't want to rebase the whole clk tree just to pull
out James' patch.

Regards,
Mike

>
> With mentioned patch these Samsung clocks depends on COMMON_CLK so they
> should not be selectable on IA64.
>
> However I don't have IA64 cross compiler to verify this.
>
> Best regards,
> Krzysztof




-- 
Michael Turquette
CEO
BayLibre - At the Heart of Embedded Linux
http://baylibre.com/
