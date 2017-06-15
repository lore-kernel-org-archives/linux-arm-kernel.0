From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Jun 2017 18:01:30 +0100
Subject: [PATCH 2/5] arm64: signal: Refactor sigcontext parsing in
 rt_sigreturn
In-Reply-To: <1497535442-11586-3-git-send-email-Dave.Martin@arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170615170130.GB17424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 03:03:39PM +0100, Dave P Martin wrote:
> Currently, rt_sigreturn does very limited checking on the
> sigcontext coming from userspace.
> 
> Future additions to the sigcontext data will increase the potential
> for surprises.  Also, it is not clear whether the sigcontext
> extension records are supposed to occur in a particular order.
> 
> To allow the parsing code to be extended more easily, this patch
> factors out the sigcontext parsing into a separate function, and
> adds extra checks to validate the well-formedness of the sigcontext
> structure.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
