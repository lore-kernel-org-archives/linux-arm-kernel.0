From: olof@lixom.net (Olof Johansson)
Date: Sat, 17 Jan 2015 13:10:11 -0800
Subject: SMBIOS/DMI data under CONFIG_STRICT_DEVMEM
In-Reply-To: <54BAC21D.9040009@redhat.com>
References: <54BAC21D.9040009@redhat.com>
Message-ID: <CAOesGMi3=QkiQ326nFfGTjsOKrGqgO-q+r+A4Uc_9YWCDrAtwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 17, 2015 at 12:12 PM, Jon Masters <jcm@redhat.com> wrote:
> Hi Catalin, all,
>
> I would like to ensure that the SMBIOS data provided by firmware is
> always readable from userspace on AArch64, through /dev/mem.

Seems like this would be a good opportunity for cleanup and fixing
userspace to use /sys/firmware/dmi interfaces instead of having to go
poking through /dev/mem. That way they don't have to be privileged
process any more and is a general security benefit for everybody.


-Olof
