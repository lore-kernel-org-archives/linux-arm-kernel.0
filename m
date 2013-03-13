From: david.woodhouse@intel.com (Woodhouse, David)
Date: Wed, 13 Mar 2013 13:35:05 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130219203115.114eab79e8d2099c6306d921@freescale.com>
References: <20130129181046.GC25415@pd.tnic>
 <1359541333.3529.186.camel@shinybook.infradead.org>
 <20130130200900.9d7cf7908caeaef4ecee1d61@freescale.com>
 <20130131092801.GV23505@n2100.arm.linux.org.uk>
 <20130131145947.f62474a0600848df86548b96@freescale.com>
 <20130201011712.GF23505@n2100.arm.linux.org.uk>
 <1359703995.23531.6.camel@shinybook.infradead.org>
 <20130205210436.670c62e26d2121330e87af35@freescale.com>
 <1360141322.6066.4.camel@shinybook.infradead.org>
 <20130206191905.ac8eb6743e69425f30888704@freescale.com>
 <20130207181315.GM17833@n2100.arm.linux.org.uk>
 <1360344301.6066.263.camel@shinybook.infradead.org>
 <alpine.LFD.2.02.1302081503430.6300@xanadu.home>
 <1360363233.6066.283.camel@shinybook.infradead.org>
 <alpine.LFD.2.02.1302081745500.6300@xanadu.home>
 <20130208191208.2ef3d78bda71aa7b44d00d7b@freescale.com>
 <alpine.LFD.2.02.1302082102380.6300@xanadu.home>
 <20130219203115.114eab79e8d2099c6306d921@freescale.com>
Message-ID: <1363181704.32099.360.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-02-19 at 20:31 -0600, Kim Phillips wrote:
> 
> > > imx_v6_v7_defconfig:        7672373         7667089         -5284
> > > lart_defconfig:     2941150         2941054         -96
> > > mxs_defconfig:      11091983        11095679        3696
> > 
> > The savings are good, with some impressive cases.  However the 
> > mxs_defconfig is completely the opposite and by far.  Any idea?
> 
> Unfortunately, I don't seem to be able to reproduce this anymore.
> Same linux-next, with three different compilers always produces
> smaller binaries:
> 
>    text    data     bss     dec     hex filename
> 5239363  280576 5569648 11089587         a936b3 linux-next-mxs-orig-gcc4.7/vmlinux
> 5239169  280556 5569648 11089373         a935dd linux-next-mxs-bswap-gcc4.7/vmlinux
> 
> 5262223  280592 5569648 11112463         a9900f linux-next-mxs-orig-gcc4.6.3/vmlinux
> 5261909  280584 5569648 11112141         a98ecd linux-next-mxs-bswap-gcc4.6.3/vmlinux
> 
> 5241379  280580 5569648 11091607         a93e97 linux-next-mxs-orig-gcc4.6ubuntu/vmlinux
> 5241189  280600 5569648 11091437         a93ded linux-next-mxs-bswap-gcc4.6ubuntu/vmlinux
> 
> So I've since made a more consistent cross-build environment, using
> cross tools from Linaro [1,2] instead of via Ubuntu [3].

Andrew Pinski has done some work on GCC to support further
optimisations: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=55177

If you feel like building with the branch at
http://gcc.gnu.org/git/?p=gcc.git;a=shortlog;h=refs/heads/pinskia/bytewiseunop and seeing how that affects the results, that could be interesting.

-- 
                   Sent with MeeGo's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6242 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130313/3150b8c1/attachment.bin>
