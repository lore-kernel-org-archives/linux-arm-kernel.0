From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Jan 2015 15:59:23 +0000
Subject: [PATCH 1/2] ARM: entry-common: fix forgotten set of
 thread_info->syscall
In-Reply-To: <CACZ9PQUEprgKrpHazDULA5mf-OaoX=MAjEeWdspZTXT_+iUKWw@mail.gmail.com>
References: <1420986751-30364-1-git-send-email-r.peniaev@gmail.com>
 <1420986751-30364-2-git-send-email-r.peniaev@gmail.com>
 <20150112183955.GO13360@arm.com>
 <CACZ9PQXW9G4Vw-dcPwkdVE=uoYmDYEQnJWDnnpup1LxC3s5QPg@mail.gmail.com>
 <CAGXu5jLO-YSaF8P9o3jcXP4VZCPYVshz73krnchYuv9pPGY6Sw@mail.gmail.com>
 <CACZ9PQVo0SF4Z-rdNk4e=yY17Xt9n5hAqm4ZRNLEw3jGYYcvtA@mail.gmail.com>
 <CAGXu5j+O6znN=7-gc3PqwqFA5MFRPLGBUzabOmQjWn_9WTjvpg@mail.gmail.com>
 <CACZ9PQUEprgKrpHazDULA5mf-OaoX=MAjEeWdspZTXT_+iUKWw@mail.gmail.com>
Message-ID: <20150116155923.GK12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 12:57:02AM +0900, Roman Peniaev wrote:
> On Fri, Jan 16, 2015 at 7:54 AM, Kees Cook <keescook@chromium.org> wrote:
> > One interesting thing I noticed (which is unchanged by this series),
> > but pulling ARM_r7 during the seccomp ptrace event shows __NR_poll,
> > not __NR_restart_syscall, even though it was a __NR_restart_syscall
> > trap from seccomp. Is there a better place to see the actual syscall?
> 
> As I understand we do not push new r7 to the stack, and ptrace uses the
> old value.

And why should we push r7 to the stack?  ptrace should be using the
recorded system call number, rather than poking about on the stack
itself.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
