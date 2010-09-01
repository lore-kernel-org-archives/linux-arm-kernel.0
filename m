From: vipin.kumar@st.com (Vipin Kumar)
Date: Wed, 1 Sep 2010 09:43:49 +0530
Subject: [PATCH 28/74] Incrementing the ecc_pos array to contain 128 char
In-Reply-To: <1283297810.2018.67.camel@brekeke>
References: <07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>	
	<a750eadbd743c3a2d5dc8b35c25e0ee82f569e87.1283161023.git.viresh.kumar@st.com>	
	<1283170469.12995.53.camel@brekeke> <4C7CA278.9040902@st.com>
	<1283297810.2018.67.camel@brekeke>
Message-ID: <4C7DD2FD.1080501@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/1/2010 5:06 AM, Artem Bityutskiy wrote:
> Hi,
> 
> On Tue, 2010-08-31 at 12:04 +0530, Vipin Kumar wrote:
>>> Nack, breaking ABI Is not allowed in Linux.
>> I could not understand your point. Can you please elaborate. How does this patch 
>> break ABI
> 
> You are changing data structure (struct nand_ecclayout) used for in MTD
> ioctl. Tha ioctl is part of the Linux ABI. By changing the data
> structure, you are breaking the ABI. This means that current binaries
> would stop working with newer versions of the Linux kernel if we'd
> accept your patch.
> 
Hello,

The only change that I have made is increasing the number of bytes to keep ecc. 
Since the ecc is generally kept in spare area, it makes sense to have the ecc 
locations to be equal to the maximum spare area possible.

A NAND page with a page size of 4096 would contain a spare area of 128 bytes. 
Now, ecc for the page can be less/more than 64 bytes(currently allocated for 
ecc positions) depending on the algorithm used to generate ecc. 
Incidently, in our case the ecc can fit in 104 bytes and this is still quite 
logical to place it in spare area since the linux image supports 4096 page but 
the problem is that the ecc locations supported by linux are less than the 
practically possible scenario so in effect this change is an improvement in linux

Please let me know if you disagree

Regards
Vipin
