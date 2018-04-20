From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Fri, 20 Apr 2018 08:55:21 -0600
Subject: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
In-Reply-To: <BN6PR12MB1809BD30AA5B890C054F9832F7B50@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
 <20180419202632.GE14063@ziepe.ca>
 <20180419214722.GO28657@bhelgaas-glaptop.roam.corp.google.com>
 <BN6PR12MB1809BD30AA5B890C054F9832F7B50@BN6PR12MB1809.namprd12.prod.outlook.com>
Message-ID: <20180420145521.GB30433@ziepe.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 10:11:27PM +0000, Deucher, Alexander wrote:

> My understanding was that some platfoms only bring up the link in
> gen 1 mode for compatibility reasons.  TBH, I'm not that familiar
> with how the links come up on different platforms.

Then the platform firmware or platform's linux PCI root complex driver
should perform speed negotiation.

Something like that shouldn't be a driver problem to solve.

The driver should only be involved if it has to alter the device (eg
new device firmware or something)..

Jason
