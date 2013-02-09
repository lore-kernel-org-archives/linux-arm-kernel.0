From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sat, 09 Feb 2013 22:03:52 +0000
Subject: [PATCH 16/17] xgmac: replace =?UTF-8?Q?=5F=5Fraw=20with=20rel?=
 =?UTF-8?Q?axed=20IO?=
In-Reply-To: <5116B8CB.40007@gmail.com>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-17-git-send-email-ben.dooks@codethink.co.uk>
 <5116B8CB.40007@gmail.com>
Message-ID: <1db4ff62c8a498edd0c1593a8f7bd6d8@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2013 20:59, Rob Herring wrote:
> On 02/08/2013 05:17 PM, Ben Dooks wrote:
>> The xgmac driver is using __raw read and write functions, where it
>> should be using readl_relaxed and writel_relaxed to avoid any issues
>> with which endian mode the CPU is running in.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>  drivers/net/ethernet/calxeda/xgmac.c |   12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> This will break on arches which don't have the _relaxed variants. 
> David
> Miller will reject restricting this to build on ARM only. See this:
>
> http://www.spinics.net/lists/netdev/msg215457.html

I was considering changing it anyway to keep the __raw functions
and simply swapping the endian-ness of the data when necessary
as we don't need about three rev instructions in there where one
will do.

Will sort out looking at this when I am back in the office on Monday.

-- 
Ben
