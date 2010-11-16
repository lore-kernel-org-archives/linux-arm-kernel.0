From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Mon, 15 Nov 2010 17:16:47 -0800
Subject: [PATCH 14/14] msm: iommu: Miscellaneous code cleanup
In-Reply-To: <1289867105.4050.29.camel@c-dwalke-linux.qualcomm.com>
References: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>	
	<1289619000-13167-15-git-send-email-stepanm@codeaurora.org>
	<1289867105.4050.29.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <4CE1DB7F.1020408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2010 4:25 PM, Daniel Walker wrote:
> On Fri, 2010-11-12 at 19:30 -0800, Stepan Moskovchenko wrote:
>> Remove some unneeded assignments and messages, restructure
>> a failure path in iova_to_phys, and make __flush_iotlb
>> return int in preparation for adding IOMMU clock control.
> Why restructure the failure path ?
>
> Daniel

It is a trivial change of replacing a goto with an assignment and moving 
it a few lines down. It reduces "jumpiness" within that function and is 
a cleaner version. On the more practical side, it was done in 
preparation for some other changes I have coming up, which touch that 
function and work a lot better with the cleaned-up failure path. The 
next patch was delayed (due to a dependency) but as long as I was doing 
code cleanup, I saw no reason not to also clean up the failure path as 
part of this series.

Steve

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
