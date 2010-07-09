From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 9 Jul 2010 11:32:47 +0300
Subject: [PATCH 11/15] wireless: wl1271: introduce platform device support
In-Reply-To: <4C36DA04.3090209@nokia.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-12-git-send-email-ohad@wizery.com>
	<4C32EF19.1000604@nokia.com>
	<AANLkTintIz-N7MwwtqhVq2LR3Ln5JTNYSbJUBSSClcA-@mail.gmail.com>
	<4C3306F4.8060907@nokia.com>
	<AANLkTin5W52fPzWToRrAzm56SLZI-taSuI16rCEhLWqH@mail.gmail.com>
	<4C333E0D.2070601@nokia.com>
	<alpine.LFD.2.00.1007061316010.6020@xanadu.home>
	<AANLkTin7jIAIiN_JHMxX74K-EBDtDNwUQMlIf4C6RCHD@mail.gmail.com>
	<4C36DA04.3090209@nokia.com>
Message-ID: <AANLkTik7eGRREWlokHenj-hGlwJXwc7IBWpSqNpoMwGI@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On Fri, Jul 9, 2010 at 11:12 AM, Roger Quadros <roger.quadros@nokia.com> wrote:
> You are already
> creating a new platform device for wl1271_sdio just to pass platform_data

With the new approach, I can remove this platform device altogether,
and completely rely on the sdio function device for driver probing (as
it was before). I just need to add this little support of delivering
small bits of platform data - the mechanism should be simple and
generic, and would considerably simplify the driver.

> I think this case is specific to wl1271.

Yes, it is.

There's an hw issue with the wl1271's in-band interrupt, so we can't
use it (the issue is fixed in the wl1281 btw).

But we also have to deliver the reference clock info to the driver,
which is board-specific data, and would be relevant to all wl12xx
devices.

Thanks,
Ohad.
