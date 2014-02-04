From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 04 Feb 2014 17:33:35 +0000
Subject: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
In-Reply-To: <52E93360.1000904@amd.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>	<
 20140117110830.GW3471@alberich>	<52E92842.3000001@amd.com> <
 CAL_JsqLhzp5jUJPA91rNkQ07kCDYCDZLxw8LxxFEVP9b12e1Jw@mail.gmail.com> <
 52E93360.1000904@amd.com>
Message-ID: <20140204173335.8C7CBC40B12@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Jan 2014 10:59:12 -0600, Suravee Suthikulanit <suravee.suthikulpanit@amd.com> wrote:
> On 1/29/2014 10:57 AM, Rob Herring wrote:
> >>> diff --git a/include/linux/of.h b/include/linux/of.h
> >>> >>index 276c546..24e1b28 100644
> >>> >>--- a/include/linux/of.h
> >>> >>+++ b/include/linux/of.h
> >>> >>@@ -67,7 +67,7 @@ struct device_node {
> >>> >>   #endif
> >>> >>   };
> >>> >>
> >>> >>-#define MAX_PHANDLE_ARGS 8
> >>> >>+#define MAX_PHANDLE_ARGS 16
> >> >
> >> >
> >> >Since the MMU-500 specify "Number of SMRs" upto 128 registers, shouldn't
> >> >this be changed to be able to support 128 StreamIDs as well?  Although I am
> >> >not sure if this would be too big to have on the stack per Rob's comment in
> >> >the previous patch set.
> > Do you actually need 128 now? If not, then we can deal with that when
> > we get there. There are lots of things in spec's that are not actually
> > implemented or supported.
> 
> Actually, we are using 32 on the AMD system. So, do you think we can set 
> this to 32 instead?

The helper really wasn't designed for large number of arguments to a
phandle. If the phandle args are really that large, then it may be
better to have a parser that allocates the space needed and/or puts the
data directly into the destination data structure.

g.
