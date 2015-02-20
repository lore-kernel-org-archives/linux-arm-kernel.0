From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Feb 2015 13:57:44 +0000
Subject: [RESEND PATCH 2/2] arm: socfpga: Set share override bit of the
 l2 cache controller
In-Reply-To: <CAL_Jsq+iBr+Pczkr_7YrcmbsfStx3yk6mYPhA-Gcb8oAtwNbxg@mail.gmail.com>
References: <1424365606-19964-1-git-send-email-dinguyen@opensource.altera.com>
 <1424365606-19964-2-git-send-email-dinguyen@opensource.altera.com>
 <CAL_JsqKmbV69Q-hgnvnz-2+2T8k-Q+WcrFmewkfozKk06ZM7OA@mail.gmail.com>
 <54E6DF09.9060505@gmail.com>
 <CAL_Jsq+iBr+Pczkr_7YrcmbsfStx3yk6mYPhA-Gcb8oAtwNbxg@mail.gmail.com>
Message-ID: <20150220135744.GH8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 07:53:50AM -0600, Rob Herring wrote:
> On Fri, Feb 20, 2015 at 1:15 AM, Dinh Nguyen <dinh.linux@gmail.com> wrote:
> > Can I ask what is your reasoning for doing this in the bootloader? It's
> > seems like this is such a nice mechanism to do it here.
> 
> Primarily, this register is secure only and we try to avoid secure
> mode setup in the kernel.
> 
> Russell also has had a patch to do this generically in his patch queue
> forever. If we want this in the kernel, then we should apply that.

I discarded it.  In general, we want boot loaders or firmware to
configure the basic properties of the caches, rather than having the
kernel do it for exactly the reasons you say above.

Yes, there are some cache features which can only be enabled in
combination with CPU features, and those the kernel _has_ to know
about, but the basic setup should be done outside the kernel.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
