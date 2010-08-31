From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 01 Sep 2010 02:36:50 +0300
Subject: [PATCH 28/74] Incrementing the ecc_pos array to contain 128 char
In-Reply-To: <4C7CA278.9040902@st.com>
References: <07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>
	<a750eadbd743c3a2d5dc8b35c25e0ee82f569e87.1283161023.git.viresh.kumar@st.com>
	<1283170469.12995.53.camel@brekeke>  <4C7CA278.9040902@st.com>
Message-ID: <1283297810.2018.67.camel@brekeke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2010-08-31 at 12:04 +0530, Vipin Kumar wrote:
> > Nack, breaking ABI Is not allowed in Linux.
> I could not understand your point. Can you please elaborate. How does this patch 
> break ABI

You are changing data structure (struct nand_ecclayout) used for in MTD
ioctl. Tha ioctl is part of the Linux ABI. By changing the data
structure, you are breaking the ABI. This means that current binaries
would stop working with newer versions of the Linux kernel if we'd
accept your patch.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
