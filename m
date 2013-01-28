From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jan 2013 13:37:16 +0000
Subject: [PATCH 00/13] ARM: spear multiplatform support
In-Reply-To: <51065F7C.3030407@st.com>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
 <51065F7C.3030407@st.com>
Message-ID: <201301281337.16951.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 January 2013, vipul kumar samar wrote:
> Hello Arnd,
> 
> On 1/26/2013 5:05 AM, Arnd Bergmann wrote:
> > This is a series I did some time ago but forgot to
> > send out earlier. I'd like to get this into v3.9,
> > so please give this a test if you can.
> 
> Me and bhavna tried to test this patch set on spear1340 and 
> spear320-hmi. We applied your patch set on the latest kernel v3.8-rc5 
> and in both case (1340 and 320-hmi) we observe that the kernel load 
> address is changed form 0x8000 to 0xfffffff2.

Hi Vipul and Bhavna,

Thanks for testing out the patches. I forgot about the loadaddress,
which indeed does not get set for multiplatform kernels, because
the kernel does not know the correct address when it depends on
the platform you are booting on.

The recommended solution for this is to boot a normal 'vmlinux'
or 'zImage' file rather than a uImage file. If you u-boot version
is too old for that and you cannot update, you can manually
call 'mkimage' to create a uImage file with the correct load
address.

	Arnd
