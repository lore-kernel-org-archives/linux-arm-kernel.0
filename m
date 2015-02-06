From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Feb 2015 15:34:59 +0000
Subject: [PATCH] arm64: Change 'Call trace' to 'Call Trace' for tool
 scanners
In-Reply-To: <1423157427-41997-1-git-send-email-ddutile@redhat.com>
References: <1423157427-41997-1-git-send-email-ddutile@redhat.com>
Message-ID: <20150206153459.GE23190@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 05:30:27PM +0000, Donald Dutile wrote:
> Receiving reports from service folks that arm64 uses
> 'Call trace' when dumping stack, instead of the more familiar
> 'Call Trace'; the former is not being seen by tools that
> scan for the latter text.  Checking various arches,
> it appears the mainstream server arches (ia64, mips, ppc,
> s390, sparc, x86) use 'Call Trace'.
> This kernel tools script scans for the latter text string as well
>   tools/testing/selftests/rcutorture/bin/parse-console.sh
> so it doesn't appear to be arch or vendor specific.
> 
> Expecting there aren't a significant number of arm64 dump
> scanners matching on 'Call trace' so recommend making this change
> now to minimize changes to dump scanning tools for arm64 servers.

Can you not fix the scripts to check for "Call trace" as well? There are
4 more architectures in the kernel using this string (avr32, c6x, metag,
sh). I also wouldn't count kernel logs as user ABI.

-- 
Catalin
