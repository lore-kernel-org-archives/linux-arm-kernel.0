From: swetland@google.com (Brian Swetland)
Date: Sun, 1 Nov 2009 15:01:19 -0800
Subject: [3/3,ARM] msm: add minimal board file for HTC Dream device
In-Reply-To: <20091101221345.GA16926@elf.ucw.cz>
References: <20091101221345.GA16926@elf.ucw.cz>
Message-ID: <a55d774e0911011501x6abdb6a2p117f7038a4fa80cf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 1, 2009 at 2:13 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> On Thu 2009-06-18 00:31:15, Brian Swetland wrote:
>> This is just enough to get the device booting and serial console
>> working. ?Sufficient for debugging further MSM7k/Dream Support.
>> This will support HTC Dream / T-Mobile G1 / Android ADP1 (which
>> are all the same hardware, known as "trout" to the ARM machine
>> database).
>>
>> Signed-off-by: Brian Swetland <swetland@google.com>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
>> Reviewed-by: GeunSik Lim <geunsik.lim@samsung.com>
>
> I'm trying to get this series to work -- i.e. get dream boot up-to
> serial console.
>
> I tried applying series on 2.6.29, and it failed compilation.
>
> On 2.6.30 and 2.6.32-rc, I get "Uncompressing linux..." feedback on
> serial, but that's it. Do you still remember what kernel version these
> should be applied to? .config would be helpful, too...

Pretty sure it's something later than .29

Does enabling DEBUG_LL help?  If something's dying before the serial
port is registered, you might never see any console chatter.

Also, I believe you'll want to pass console=ttyMSM2,115200n8 on the
kernel commandline  (-c parameter to fastboot or mkbootimg).

Brian
