From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 2 Jun 2017 15:37:51 +0300
Subject: arm64: segfaults on next-20170602 with LTP tests
In-Reply-To: <20170602121917.GG6371@arm.com>
References: <20170602111151.r2x3364zqabmshzo@yury-thinkpad>
 <20170602121917.GG6371@arm.com>
Message-ID: <20170602123751.3jzdkjwntbce2e6e@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 01:19:18PM +0100, Will Deacon wrote:
> Hi Yury,
> 
> [adding Steve and Punit]
> 
> On Fri, Jun 02, 2017 at 02:11:51PM +0300, Yury Norov wrote:
> > I see that latest and yesterday's linux-next segfaults with tests pth_str01,
> > pth_str03, rwtest04. Rwtest04 hangs sometimes. Crashes are not always
> > reproducible. About week ago everything was fine. Kernel log and config file
> > are attached. The testing is performed on qemu.
> 
> It's weird that these haven't cropped up in our nightly tests, especially
> given that defconfig is very similar to the one you're using. That said,
> I see huge pmds cropping up in the traces below and there have been some
> recent changes from Punit and Steve in that area, in particular things
> like 55f379263bcc ("mm, gup: ensure real head page is ref-counted when using
> hugepages").
> 
> Are you in a position to bisect this, or is it too fiddly to reproduce?

I think I can.

Yury
