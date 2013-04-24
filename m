From: girishks2000@gmail.com (Girish KS)
Date: Wed, 24 Apr 2013 15:07:47 +0530
Subject: [PATCH 1/3] spi: s3c64xx: added support for polling mode
In-Reply-To: <20130423151511.GR5019@opensource.wolfsonmicro.com>
References: <1366614565-3743-1-git-send-email-ks.giri@samsung.com>
 <1366614565-3743-2-git-send-email-ks.giri@samsung.com>
 <20130423151511.GR5019@opensource.wolfsonmicro.com>
Message-ID: <CAKrE-KcGecFNnyKj9AdDYwBOw_OO4o_V2DMjHmYX092fh4EQgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 8:45 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 22, 2013 at 12:39:23PM +0530, Girish K S wrote:
>> From: Girish K S <girishks2000@gmail.com>
>>
>> The 64xx spi driver supports partial polling mode.
>> Only the last chunk of the transfer length is transferred
>> or recieved in polling mode.
>
> This appears to have a very noticable negative impact on SPI performance
> on my S3C6410 based system.  Not delved into it to test why but are you
> sure it's not mistakenly selecting polling?

If forced to polling you should see this message "Unable to get SPI rx
dma resource. Switching to poll mode". same if Tx dma resource is not
available from platform data.
Anyways let me cross check again on my tested systems.
