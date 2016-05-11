From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 11 May 2016 15:30:30 -0700
Subject: [PATCH 4/5] remoteproc: core: Supply framework to request,
 declare and fetch shared memory
In-Reply-To: <1462454983-13168-5-git-send-email-lee.jones@linaro.org>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
 <1462454983-13168-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20160511223030.GZ1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 05 May 06:29 PDT 2016, Lee Jones wrote:

> Normally used for management of; carveout, devmem and trace memory.
> 

I like the gist of this, but I have two issues from the Qualcomm land
that I think would tie into a slightly more generic version of this.

1) Registering carveouts from memory-regions, without having a resource
   table.
2) Tying the Qualcomm shared memory implementation to the appropriate
   remoteproc instance (e.g. for crash handling).

I also think we should match the subdev with entries from the resource
table based on some key, so that we don't add a limitation of only
having a single carveout per rproc.


I will do some prototyping based on your patch and will get back to you.

Regards,
Bjorn
