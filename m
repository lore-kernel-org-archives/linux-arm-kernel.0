From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Wed, 21 Aug 2013 12:46:51 -0700
Subject: [PATCH RFC 0/2] PM / Hibernate: sysfs resume 
Message-ID: <1377114413-8521-1-git-send-email-sebastian.capella@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patchset related to hibernation resume: one enhancement to make the use
of an existing file more general and one documentation update.

Both patches are based on the 3.11-rc6 tag.  This was tested on a
Pandaboard with partial hibernation support, and compiled on x86.

Further testing is needed on other platforms.  Please let me know if
you're able to verify this on any other systems.

[PATCH RFC 1/2] PM / Hibernate: use name_to_dev_t to parse resume
  Use name_to_dev_t to parse the /sys/power/resume file making the
  syntax more flexible.  It supports the previous use syntax
  and additionally can support other formats such as
  /dev/devicenode and UUID= formats.

  By changing /sys/debug/resume to accept the same syntax as
  the resume=device parameter, we can parse the resume=device
  in the initrd init script and use the resume device directly
  from the kernel command line.

  kernel/power/hibernate.c |   14 +++++++++-----
  1 file changed, 9 insertions(+), 5 deletions(-)

[PATCH RFC 2/2] PM / Hibernate: add section for resume options
  This adds a small section to the swsusp.txt file to address the
  options for resuming.  This comments on the manual resume
  option which is used when resorting to an initrd or initramfs
  for resuming.  Resuming from late init is discussed later in
  the document, but it seemed appropriate to list them together.

  Documentation/power/swsusp.txt |   15 ++++++++++++++-
  1 file changed, 14 insertions(+), 1 deletion(-)

Thanks,

Sebastian
