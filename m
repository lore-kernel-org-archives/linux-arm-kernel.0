From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Jan 2015 20:37:51 +0000
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <201501262016.52079@pali>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201412041857.49341@pali>
 <CAL_JsqJ9i0jwaL1cyeomQG=bhhcnEgdGWYOqkcwidyk5xOUukg@mail.gmail.com>
 <201501262016.52079@pali>
Message-ID: <20150126203751.GK26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 08:16:52PM +0100, Pali Roh?r wrote:
> This patch will cause that decompressor store full ATAG structure into
> DT tree ("/atags"):

How about something a little more radical.

Rather than trying to squeeze various ATAGs into DT, why don't we add a
standard ATAG to contain the DT and pass that through into the kernel.
This is IMHO how we _should_ have done the ATAG compatibility from the
start.

That means we could get rid of most of the libfdt in the decompressor,
and instead resolve the differences in the kernel.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
