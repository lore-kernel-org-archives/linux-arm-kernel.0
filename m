From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 17 Mar 2010 10:09:53 -0400
Subject: [PATCH 7/8] [ARM] pxa: move ssp into common plat-pxa
In-Reply-To: <20100317100538.GC13166@opensource.wolfsonmicro.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
	<1268740373-27407-8-git-send-email-eric.y.miao@gmail.com>
	<771cded01003160549t73b30cccr7ba56722c28f013c@mail.gmail.com>
	<20100316125955.GB7287@rakim.wolfsonmicro.main>
	<f17812d71003160604q38846792i18efbcf9fb7208f@mail.gmail.com>
	<20100316132305.GA8875@rakim.wolfsonmicro.main>
	<f17812d71003160647v22569487k4f767da7dae6d298@mail.gmail.com>
	<20100316140834.GB9365@rakim.wolfsonmicro.main>
	<f17812d71003162214y10e98491v928b5c51d1bf2616@mail.gmail.com>
	<20100317100538.GC13166@opensource.wolfsonmicro.com>
Message-ID: <771cded01003170709g7967192bhec65ac337051e11f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 5:05 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 17, 2010 at 01:14:39PM +0800, Eric Miao wrote:
>
>> I'm seeing no merge conflict between my ssp_cleanup and Takashi's
>> latest tree, which branch do you suggest to merge then?
>
> I'm not sure what you're asking here but if you're looking for any
> incompatible changes in ASoC they've not been implemented yet, the issue
> is that due to the stuff Liam is working on at the minute there are
> likely to be incompatible changes in the current release cycle which
> would mean that merging new drivers (like Haojian posted) via a non-ALSA
> tree would lead to problems after the trees are been merged together.
>

Hi Mark & Eric,

There're some ssp fixes after 2.6.34-rc1 that result ssp code
different between pxa tree and asoc tree (neither Eric's ssp cleanup
patch nor my patch). If those fixes  could be merged into 2.6.34-rc2,
I want to know whether ASoC tree will sync to them. If so, it seems
that we could work at the same point. What's your opinion, Mark?

By the way, I reformat my patches on Eric's git since one of my patch
is contained in his branch. Now I attach them for review first.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ASoC-split-pxa-ssp-for-reusing-code.patch
Type: text/x-patch
Size: 43910 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100317/6cc81079/attachment-0005.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002--ARM-pxa-remove-ifdef-in-ssp.h.patch
Type: text/x-patch
Size: 4501 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100317/6cc81079/attachment-0006.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003--ARM-mmp-support-ssp-in-pxa168.patch
Type: text/x-patch
Size: 8934 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100317/6cc81079/attachment-0007.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-ASoC-support-codec-via-ssp-interface-in-aspenite.patch
Type: text/x-patch
Size: 20797 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100317/6cc81079/attachment-0008.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0005--ARM-mmp-enable-ssp-in-aspenite.patch
Type: text/x-patch
Size: 1444 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100317/6cc81079/attachment-0009.bin>
