From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 1 Dec 2015 11:49:29 -0500
Subject: [PATCH v2 1/2] scripts: Add a recorduidiv program
In-Reply-To: <20151201161944.GX8644@n2100.arm.linux.org.uk>
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-2-git-send-email-sboyd@codeaurora.org>
 <20151125234711.GT8644@n2100.arm.linux.org.uk>
 <565C6714.802@suse.com>
 <20151130153208.GR8644@n2100.arm.linux.org.uk>
 <565C6DE9.2020302@suse.com> <565DC5A9.2010305@suse.cz>
 <20151201161944.GX8644@n2100.arm.linux.org.uk>
Message-ID: <20151201114929.655433a2@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Dec 2015 16:19:44 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
 
> They hardly "do nothing", as the (eg) recordmcount plasters the build
> log with warnings.  A solution to that would be to make recordmcount
> silent if the section is already present.

Note, that warning found plenty of bugs when modifications of the build
system was being done and broke recordmcount.c. I really don't want to
silent it.

But for some reason, your build is causing lots of warnings and not for
others. Perhaps we can add a "SILENT_RECORDMCOUNT" environment variable
and have it set when something like CCACHE_HARDLINK or whatever is
causing it to trigger when we don't care.

-- Steve
