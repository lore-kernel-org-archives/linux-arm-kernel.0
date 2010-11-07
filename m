From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 7 Nov 2010 17:17:26 +0000
Subject: [PATCH 1/6 v2] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <AANLkTimFJ=Brx4pDiUqZOKDfABaDg0s_yFC7EkZGi7D8@mail.gmail.com>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<20101107165745.GB1759@n2100.arm.linux.org.uk>
	<AANLkTimFJ=Brx4pDiUqZOKDfABaDg0s_yFC7EkZGi7D8@mail.gmail.com>
Message-ID: <20101107171726.GF1759@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 07, 2010 at 08:08:45PM +0300, Alexey Charkov wrote:
> I believe it can. Thanks for the info, I just didn't know about that.
> Will fix this shortly.
> 
> Is it OK to leave resources assignment in map_io or is there a better
> place to do that as well?

Well, surely resources don't need to be set this early, because
they're not going to be used before their associated devices are
registered - which presumably happens in your init_machine callback.
So, can you not call a function from the init_machine callbacks to
setup these resources?
