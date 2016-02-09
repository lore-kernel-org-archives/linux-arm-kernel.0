From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 9 Feb 2016 11:08:15 -0500
Subject: [PATCH] arm64: replace read_lock to rcu lock in call_step_hook
In-Reply-To: <20160209160442.GS22874@arm.com>
References: <1454971764-30720-1-git-send-email-yang.shi@linaro.org>
 <20160209145426.GR22874@arm.com>
 <20160209100758.69d9006f@gandalf.local.home>
 <20160209160442.GS22874@arm.com>
Message-ID: <20160209110815.749c9e26@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Feb 2016 16:04:42 +0000
Will Deacon <will.deacon@arm.com> wrote:
 
> > The patch looks good to me. Do you want to take it through your tree?
> > 
> > It benefits mainline too as a rcu_read_lock() is more efficient than
> > rwlocks. Although I will say this is a slow path anyway.  
> 
> I was thinking that Catalin would queue it for 4.6 in the arm64 tree,
> since that's probably easiest in case any unlikely conflicts crop up.

Oh, OK.

That's fine. I just didn't want you to think that the RT folks were
going to pull it in for mainline.

-- Steve
