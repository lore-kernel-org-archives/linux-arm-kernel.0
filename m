From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jan 2017 15:43:02 +0000
Subject: [PATCH 1/2] ARM: hyp-stub: improve ABI
In-Reply-To: <20170109150138.GJ4348@cbox>
References: <20161215113539.GK14217@n2100.armlinux.org.uk>
 <06fca797-da5d-f7f2-eecb-9b1b33b7e83f@arm.com>
 <20161215151548.GL14217@n2100.armlinux.org.uk>
 <c21d6514-44a2-ba88-0fe5-d14d5897cc48@arm.com>
 <20161215185717.GM14217@n2100.armlinux.org.uk>
 <20170103095149.GA14242@cbox>
 <20170109122639.GX14217@n2100.armlinux.org.uk>
 <20170109132636.GH4348@cbox>
 <20170109140500.GA14217@n2100.armlinux.org.uk>
 <20170109150138.GJ4348@cbox>
Message-ID: <20170109154302.GF14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 04:01:38PM +0100, Christoffer Dall wrote:
> Nobody is arguing with the need for documentation, and I think I
> understan the reason for needing to support a common ABI with a common
> set of functions regardless of the logic in place in Hyp mode.
> 
> We just have to agree on a sane ABI and I'll be happy to help
> write/review the API docs and clean things up.

Let me make this crystal clear - this is where I am with this problem.

I've identified many issues with the ABI, and that there are several
differnet chunks of code which are a problem.

Although I've proposed a change to the hyp-stub ABI, which has since
been found to be insufficient, right now I have no better suggestions
to make.  I'm operating in an information vaccuum here, and it is not
yet clear to me what changes to the hyp-stub and KVM ABI would be
acceptable.  I don't know what environment the KVM hypervisor operates
in yet, eg whether it can see the kernel, whether it can see the IDMAP
region, etc.

Why would the IDMAP region be important?  The hyp-stub doesn't setup
any page tables, so it seems to operate without any MMU translation.
That rather rules out passing virtual address pointers through a
common hyp-mode interface.

However, it seems that the KVM hypervisor does setup MMU translations,
making virtual addresses acceptable but physical/IDMAP addresses not.

So, right now I've no idea what a replacement ABI would look like.

Hence, the lack of _current_ documentation is hampering the situation.

Now, you've said to me privately that you think my demands for
documentation are unwarranted.  I've been trying to gain enough
understanding that I can move forward, with my requests for
documentation being treated as "we'll do that later."  Well, given
that, it leads me to only one possible outcome.

Enough is enough.  Since there's no movement on the documentation
front, and because you're now saying that my demands for documentation
are unreasonable, I've reached the end of the road.  There's nothing
more that I'm willing to do on this problem - at least not until there's
a change of heart wrt documentation.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
