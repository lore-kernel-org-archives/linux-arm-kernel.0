From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Mar 2011 14:12:10 +0100
Subject: Support for ARM940T core Samsung S3C2510A MCU under Linux
In-Reply-To: <AANLkTik1jSNpuREDuX3-LhNafD43m5T=14ZDwNUC5a8X@mail.gmail.com>
References: <AANLkTinSMPPHzmp5e1JrPByXC0XCY-591S=jGATXHR=U@mail.gmail.com>
	<4D87363A.7090209@snapgear.com>
	<AANLkTik1jSNpuREDuX3-LhNafD43m5T=14ZDwNUC5a8X@mail.gmail.com>
Message-ID: <201103221412.10916.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 March 2011, Madhavi Manchala wrote:

> These sources (patches) are similar to samsung sources which are
> available in uClinux-dist. So, I will look into the Ithamar Adema
> patches and uClinux-dist samsung machine directory sources. Please
> suggest me.
> 
> My final question, All these samsung machines (s3c24a0, s3c3410,
> s3c44b0x and s5c7375) are ARM7TDMI core based MCUs. My MCU (Samsung
> s3c2510A) is a ARM9TDMI core based. So, is this porting will help?

The CPU support is really separate from the platform, and
ARM9TDMI/ARM940T is supported by the platform-independent code.

In the s3c2510-specific portion, you should need very little
code that has dependencies on the specific ARM code besides
for the Kconfig 'select CPU_ARM940T' statement.

> I am extreamly sorry, If I asked silly questions here.

No problem at all, these things are not well documented, so it's
good if at least people can refer to this conversation in the
email archives.

	Arnd
