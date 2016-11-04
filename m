From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Nov 2016 09:50:39 -0600
Subject: [RFC PATCH v2 8/8] arm64: Wire up and expose the new compat vDSO
In-Reply-To: <20161027163058.12156-9-kevin.brodsky@arm.com>
References: <20161027163058.12156-1-kevin.brodsky@arm.com>
 <20161027163058.12156-9-kevin.brodsky@arm.com>
Message-ID: <20161104155039.5lxubpyt2dsuqxef@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 05:30:58PM +0100, Kevin Brodsky wrote:
> * The vDSO page replaces the vector page. The vDSO provides its own
>   sigreturn trampolines, replacing those in the vector page, but the
>   kuser helpers are gone. As a result enabling the compat vDSO will
>   break userspace programs relying on the kuser helpers.

I think vDSO and vectors page should not exclude each other. If you want
to disable the vectors page, let's make it an independent config option
like the KUSER_HELPERS in arch/arm64/mm/Kconfig. But I would very much
like to be able to have both the vDSO and the vectors page at the same
time.

-- 
Catalin
