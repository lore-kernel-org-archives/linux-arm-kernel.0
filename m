From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 10 Jan 2013 17:01:50 +0300
Subject: [PATCH v5 2/3] sta2x11_vip: convert to videobuf2 and control
 framework
In-Reply-To: <1357822010-30419-3-git-send-email-federico.vaga@gmail.com>
References: <1357822010-30419-1-git-send-email-federico.vaga@gmail.com>
 <1357822010-30419-3-git-send-email-federico.vaga@gmail.com>
Message-ID: <20130110140150.GA19949@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This would be easier to review if it were broken up into separate
patches.

1) There are superflous white spaces changes
2) Changes to the copyright
3) pr_warning => pr_warn
4) The REG_READ and REG_WRITE macros are now inline functions
5) KBUILD_MODNAME is used instead of DRV_NAME
6) It now uses the video_drvdata() function
7) Lots of comments deleted.  For exmple, vidioc_enum_fmt_vid_cap()
   didn't change.  Just the comments were deleted.
8) Comments added for existing code.
9) Other behavior changes not related to using videobuf2 like in
   vidioc_try_fmt_vid_cap().
10) etc...

If all the uninteresting changes are in separate patches it makes
the complicated stuff much shorter and easier to review.

regards,
dan carpenter
