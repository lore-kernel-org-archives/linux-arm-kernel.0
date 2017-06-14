From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Jun 2017 13:01:55 +0200
Subject: [PATCH] tee: add forward declaration for struct device
In-Reply-To: <20170614094610.GA12598@jax>
References: <6344683a299d05692ed64ddb963343ea9547add4.1496229347.git.jerome.forissier@linaro.org>
 <2bcbf7b0-7dba-7e72-72fd-4da922e442bb@linaro.org> <20170614094610.GA12598@jax>
Message-ID: <CAK8P3a05K_POUxrNcyA7LVGB5qGBKmzvp-++TcLVFB2JWDdseA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 11:46 AM, Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> On Wed, Jun 14, 2017 at 11:39:50AM +0200, Jerome Forissier wrote:
>> [+Arnd]
>>
>> Ping?
>>
>> Thanks,
>> --
>> Jerome
>>
>> On 05/31/2017 01:21 PM, Jerome Forissier wrote:
>> > tee_drv.h references struct device, but does not include device.h nor
>> > platform_device.h. Therefore, if tee_drv.h is included by some file
>> > that does not pull device.h nor platform_device.h beforehand, we have a
>> > compile warning. Fix this by adding a forward declaration.
>> >
>> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Do we need this to fix a warning in mainline, in linux-next, or only
in combination with some other patches?

I have not run into this warning in my build testing.

>> >  include/linux/tee_drv.h | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>> > index 8614713..07bd226 100644
>> > --- a/include/linux/tee_drv.h
>> > +++ b/include/linux/tee_drv.h
>> > @@ -29,6 +29,7 @@
>> >  #define TEE_SHM_DMA_BUF            BIT(1)  /* Memory with dma-buf handle */
>> >  #define TEE_SHM_EXT_DMA_BUF        BIT(2)  /* Memory with dma-buf handle */
>> >
>> > +struct device;
>> >  struct tee_device;
>> >  struct tee_shm;
>> >  struct tee_shm_pool;
>> >
>
> Looks good to me.
>
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Can you pick up the patch in your git tree and send a pull request for
the appropriate release (4.12-fixes or 4.13)?

If you don't expect to send anything else for tee in that release,
you can also forward the patch to arm at kernel.org and ask for
inclusion. If you just reply with the 'Reviewed-by', I would not
expect to have to do anything in the arm-soc tree.

     Arnd
