From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Feb 2015 17:37:18 +0000
Subject: [PATCH] arm64: Change 'Call trace' to 'Call Trace' for tool
 scanners
In-Reply-To: <1423157427-41997-1-git-send-email-ddutile@redhat.com>
References: <1423157427-41997-1-git-send-email-ddutile@redhat.com>
Message-ID: <20150205173718.GS8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 12:30:27PM -0500, Donald Dutile wrote:
> Receiving reports from service folks that arm64 uses
> 'Call trace' when dumping stack, instead of the more familiar
> 'Call Trace'; the former is not being seen by tools that
> scan for the latter text.  Checking various arches,
> it appears the mainstream server arches (ia64, mips, ppc,
> s390, sparc, x86) use 'Call Trace'.
> This kernel tools script scans for the latter text string as well
>   tools/testing/selftests/rcutorture/bin/parse-console.sh
> so it doesn't appear to be arch or vendor specific.

That script should also be changed to accept "Backtrace" which we've had
for eons on ARM.  I would not be happy to change that given that ARM has
used "Backtrace" there for a very long time now (not far off 20 years.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
