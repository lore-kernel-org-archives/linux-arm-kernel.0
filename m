From: mhowe@cwlinux.com (Morgan Howe)
Date: Fri, 1 Oct 2010 16:00:35 +0800
Subject: USB Mass Storage write problem
Message-ID: <20101001160035.7c67e481@morgan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

We're working on an mx27 based board with 2 SD cards mounted as USB
mass storage devices.  The test we are doing is basically as follows:

1) Copy 1MB file to SD1
2) Copy same file from SD1 to SD2
3) sync
.. Repeat until disk full

During the test process nothing will ever report failure, however,
after the test completes, doing an MD5 check of the files will show
that some files were not written properly.  The file sizes are all
correct, but checking the contents we can see that in the bad files, at
some arbitrary point in the file it will stop writing the actual data
and the rest of the file will just be zero-filled.  The subsequent files
after the bad one will be perfectly fine for a while (usually >1GB
worth of files) and then randomly another file will get corrupted in
this manner.  Using 2 16GB SD cards we usually see around 2-6 bad files
for a full test run (until disk full).  We have tested this in both the
2.6.22.6 kernel and 2.6.35.

Has anyone experienced anything like this or have some idea where to
look?  I found this thread[1] which seemed related, but I'm running the
test program for that issue and so far no errors reported.  Any
suggestions would be appreciated.

Regards,
Morgan

[1] http://lkml.org/lkml/2010/3/4/220
