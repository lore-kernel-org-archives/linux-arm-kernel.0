From: emil@limesaudio.com (Emil Lundmark)
Date: Tue, 11 Oct 2016 11:58:52 +0200
Subject: [PATCH v2 1/2] clk: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <CAOMZO5C56tiXjBArgqZuMdu8_MB6Gq3=xWX65WNvQv+=r6VjGQ@mail.gmail.com>
References: <cover.1476092427.git.emil@limesaudio.com>
 <4e8696869cc82443825a590966bbd3a265befdfa.1476092427.git.emil@limesaudio.com>
 <CAOMZO5C56tiXjBArgqZuMdu8_MB6Gq3=xWX65WNvQv+=r6VjGQ@mail.gmail.com>
Message-ID: <20161011095852.GB8477@lime>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 11:08:40AM -0300, Fabio Estevam wrote:
> On Mon, Oct 10, 2016 at 7:03 AM, Emil Lundmark <emil@limesaudio.com> wrote:
> > Since 'parent_rate * mfn' may overflow 32 bits, the result should be
> > stored using 64 bits.
> 
> It would be nice to add the text you put in the cover letter where you
> explain the PLL4 clock discrepancy here in the commit log.

I will do that in v3.
 
> >
> > Fixes: ba7f4f557eb6 ("clk: imx: correct AV PLL rate formula")
> 
> Would be nice to Cc the author of this commit (Anson Huang). Added on Cc.

Good point, will keep this in mind in the future.
 
> Another hint: ./scripts/get_maintainer.pl  drivers/clk/imx/clk-pllv3.c
> gives you some suggestions on people and lists to add to Cc.

I did that, but read somewhere that you should send it to the maintainers
and CC the appropriate list. Should I also send it to reviewers?

Since this patch series only affects i.MX, I chose to not include the
people from the common clock framework. Was that wrong?

-- 
Emil Lundmark
