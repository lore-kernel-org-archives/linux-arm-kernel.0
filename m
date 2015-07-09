From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 9 Jul 2015 12:25:25 -0600
Subject: [PATCH v4 3/5] tee: generic TEE subsystem
In-Reply-To: <20150709124908.GA27483@ermac>
References: <1436350592-7732-1-git-send-email-jens.wiklander@linaro.org>
 <1436350592-7732-4-git-send-email-jens.wiklander@linaro.org>
 <20150708171026.GA11740@obsidianresearch.com>
 <20150709124908.GA27483@ermac>
Message-ID: <20150709182525.GA27758@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 02:49:08PM +0200, Jens Wiklander wrote:
> > Generally in a scheme like this we'd see open and release get/put the
> > underlying module handle to prevent driver removal while the char dev
> > is open. Otherwise module removal will hang here.
> 
> I'm perhaps misunderstanding you. While the cdev has any open file
> descriptors rmmod will fail with "Resource temporarily unavailable"
> because of fops_get() in chrdev_open().

Hmm, I see, you've done this:

+       cdev_init(&teedev->cdev, &tee_fops);
+       teedev->cdev.owner = teedesc->owner;

And owner here is the driver module? Interesting.. Looks OK..

Jason
