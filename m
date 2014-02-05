From: jmorris@namei.org (James Morris)
Date: Thu, 6 Feb 2014 01:02:22 +1100 (EST)
Subject: [PATCH] security: select correct default LSM_MMAP_MIN_ADDR on
 arm on arm64
In-Reply-To: <20140205114832.GB7550@arm.com>
References: <1391480133-27149-1-git-send-email-ccross@android.com>
 <20140205114832.GB7550@arm.com>
Message-ID: <alpine.LRH.2.02.1402060100590.24936@tundra.namei.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Feb 2014, Catalin Marinas wrote:

> On Tue, Feb 04, 2014 at 02:15:32AM +0000, Colin Cross wrote:
> > Binaries compiled for arm may run on arm64 if CONFIG_COMPAT is
> > selected.  Set LSM_MMAP_MIN_ADDR to 32768 if ARM64 && COMPAT to
> > prevent selinux failures launching 32-bit static executables that
> > are mapped at 0x8000.
> > 
> > Signed-off-by: Colin Cross <ccross@android.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: James Morris <james.l.morris@oracle.com>

Probably makes sense to push this through the arm tree.


-- 
James Morris
<jmorris@namei.org>
