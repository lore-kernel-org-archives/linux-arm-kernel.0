From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 14 Nov 2016 10:44:32 -0500
Subject: [PATCH] ARM: ftrace: fix syscall name matching
In-Reply-To: <20161114104008.36e9c40d@gandalf.local.home>
References: <1479128625-20948-1-git-send-email-rabin.vincent@axis.com>
 <20161114134017.GJ1041@n2100.armlinux.org.uk>
 <20161114104008.36e9c40d@gandalf.local.home>
Message-ID: <20161114104432.3bd2fb2c@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Nov 2016 10:40:08 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:


> > Is this really safe?  What guarantees that we can wind forward four
> > bytes here?  If it's always safe, it needs a better comment than just
> > two words.  
> 
> I believe it is, but a comment would do well.

Also, the generic function that is called if the arch does not define
ARCH_HAS_SYSCALL_MATCH_SYM_NAME does this too.

	return !strcmp(sym + 3, name + 3);

And looking at this, it really should be + 4 and not + 3, because it
doesn't match the comment above, where it says it can handle both
".SyS" and "SyS", but it doesn't handle ".SyS" compared to ".sys".

-- Steve
