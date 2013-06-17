From: oliver+list@schinagl.nl (Oliver Schinagl)
Date: Mon, 17 Jun 2013 15:47:36 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <2650626.N0ZZQX0iR6@amdc1227>
References: <1371251781-17167-1-git-send-email-oliver+list@schinagl.nl>
 <1894396.Y9rMOhn2P3@amdc1227> <51BF0AD7.1070101@schinagl.nl>
 <2650626.N0ZZQX0iR6@amdc1227>
Message-ID: <51BF1378.2060707@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-06-13 15:23, Tomasz Figa wrote:
> On Monday 17 of June 2013 15:10:47 Oliver Schinagl wrote:
>> On 17-06-13 14:51, Tomasz Figa wrote:
>>> On Monday 17 of June 2013 12:36:47 Oliver Schinagl wrote:
>>>> On 15-06-13 12:28, Tomasz Figa wrote:
<snip>
>> Now we pass this array to add_randomness(array, 16). So add_randomness
>> sees 16 ints in an array. So while there will be a lot of extra zero's,
>> there still be 16 elements copied/processed, no?
>
> The second argument of add_randomness is number of bytes, not number of
> elements in array, as far as I can tell.
Oh wow, very good catch. I had to dig a little into the source where it
said 'nbytes'. I guess the function prototype would have been nicer if it
said nbytes instead of size.

Anyway, with using an array of u8 this is nicely handled.

> Best regards,
> Tomasz
>
oliver
