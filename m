From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 May 2018 23:51:14 +0100
Subject: [RFC 12/13] ARM: dts: ti: add dra71-evm FIT description file
In-Reply-To: <a43ce521-ed7f-6126-4ebf-5e0e303d00a3@gmail.com>
References: <1523956215-28154-1-git-send-email-t-kristo@ti.com>
 <1523956215-28154-13-git-send-email-t-kristo@ti.com>
 <20180417092924.GB20335@flint.armlinux.org.uk>
 <ad5ef67d-d566-0034-a7cd-09a549cbd6d7@ti.com>
 <20180417144913.GD5669@atomide.com>
 <43ff3894-a287-1558-687c-40f50712735c@ti.com>
 <20180522200100.GA23937@rob-hp-laptop>
 <16a6017f-96c8-42d8-38bc-5cdd36d6793f@gmail.com>
 <20180529173314.GN17671@n2100.armlinux.org.uk>
 <a43ce521-ed7f-6126-4ebf-5e0e303d00a3@gmail.com>
Message-ID: <20180529225114.GO17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 03:45:12PM -0700, Frank Rowand wrote:
> If the kernel applies the overlay, an alternative to drivers is that the
> kernel could receive the overlay(s) in a similar manner as the method it
> currently receives the base devicetree.  (The overlay(s) could be
> appended to the base devicetree, a wrapper could be placed around the

No wrappers, sorry.  We already have too many places in the Linux
kernel and its decompressor that try to work out whether a device
tree or ATAGs are present and how large, and that is done in assembly
code.  We don't need more complexity to deal with some kind of
wrapping of device trees as well.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
