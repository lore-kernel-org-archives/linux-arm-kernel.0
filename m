From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Wed, 27 Apr 2011 00:53:44 +0300
Subject: Runtime CPU features detection on ARM (/proc/cpuinfo vs.
	/proc/self/auxv)
Message-ID: <BANLkTikaHJhz2JVceVUtZnwOdS_egixifg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Is the format of /proc/cpuinfo stable and guaranteed to remain the
same in the future versions of the linux kernel? I did a bit of
searching over the mailing lists and [1], [2] suggest that it is
highly likely. I apologize if I missed something and this question is
supposed to have been already answered, but I still would like to have
a clear confirmation just in case. Additionally, the most
authoritative source of information preferably would be some text file
under 'Documentation/arm' directory in the linux kernel sources,
formally describing /proc/cpuinfo format as needed for the automated
parsers.

At least one more alternative for detecting cpu features is to use
AT_HWCAP from ELF auxiliary vector. But unfortunately it turned out to
have some practical issues with qemu-user [3] and valgrind [4]. Using
/proc/cpuinfo also provides more information about the cpu type and
its revision, which could be used to get more performance for each
particular cpu variant and avoid hardware bugs. Looks like 'Features',
'CPU implementer', 'CPU architecture', 'CPU variant', 'CPU part' and
'CPU revision' have more or less complete set of information about the
processor for userspace applications.

Or maybe somebody can suggest a better method for runtime CPU features
detection? Thanks.


1. http://lists.arm.linux.org.uk/lurker/message/20090226.082730.69926605.en.html
2. http://lists.arm.linux.org.uk/lurker/message/20091112.221307.62810e83.en.html
3. http://comments.gmane.org/gmane.comp.graphics.pixman/733
4. http://bugs.kde.org/show_bug.cgi?id=253519

-- 
Best regards,
Siarhei Siamashka
