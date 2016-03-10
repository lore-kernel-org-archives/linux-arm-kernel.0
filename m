From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 10 Mar 2016 10:58:30 +0300
Subject: [PATCH 1/2] vfio, platform: add support for ACPI while detecting
 the reset driver
In-Reply-To: <56DEF1BE.8010701@codeaurora.org>
References: <1457451209-21462-1-git-send-email-okaya@codeaurora.org>
 <56DEF1BE.8010701@codeaurora.org>
Message-ID: <20160310075830.GB5273@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 10:37:34AM -0500, Sinan Kaya wrote:
> On 3/8/2016 10:33 AM, Sinan Kaya wrote:
> > +	int rc = 0;
> > +
> 
> I should have initialized this to -1. 
> 

-1 is a magic number which stands for -EPERM which is wrong.  Use
-ENODEV.

regards,
dan carpenter
