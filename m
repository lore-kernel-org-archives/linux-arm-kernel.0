From: keescook@chromium.org (Kees Cook)
Date: Fri, 20 Apr 2018 13:04:31 -0700
Subject: Reporting more CPU features in /proc/cpuinfo
Message-ID: <CAGXu5jKpU+pCi_S9PPqG9pYezkzjekXPohyBXJmXe87GqCEGnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'd like to have more CPU features visible in /proc/cpuinfo so it's
possible to determine from userspace if the running system has various
defenses. For example, I'd like to know that a device has hardware PXN
and PAN. (I'd love to see emulated features listed separately too, but
I could imagine that not being a great match for /proc/cpuinfo.)

One specific reason for this to do basic feature testing from
userspace without needing to catch the boot-time dmesg output. For
example, being able to answer the question "Does this system provide
PAN?" The answer is yes if either emulated PAN is visible in
/proc/config.gz or if hw PAN Is provided by the CPU (which I'd expect
to discover via /proc/cpuinfo like on x86 for things like SMAP).

Thoughts?

-Kees

-- 
Kees Cook
Pixel Security
