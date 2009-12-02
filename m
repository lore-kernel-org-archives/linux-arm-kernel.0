From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 02 Dec 2009 10:03:00 +0100
Subject: USB support on i.MX27
In-Reply-To: <4B162897.1080402@epfl.ch>
References: <37367b3a0911240343u58e3b3d2le5d48e638348a3ad@mail.gmail.com>	<eedb5540911242252w62f0a1cfo3a3f24dfa060957b@mail.gmail.com>	<20091127101654.GP14091@buzzloop.caiaq.de>	<37367b3a0911300707l2abafe3buf99f624c3c90b99@mail.gmail.com>	<37367b3a0911301157k2a15cb80q5624cbd3f96063b8@mail.gmail.com>	<37367b3a0912010616r26ff385bqe6b85db1c510822f@mail.gmail.com>	<20091201142609.GP14091@buzzloop.caiaq.de>	<37367b3a0912010651s2f7b6d0csc8fc73e088195697@mail.gmail.com>
	<4B162897.1080402@epfl.ch>
Message-ID: <4B162D44.3070709@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Valentin Longchamp a ?crit :
> Alan Carvalho de Assis wrote:
>> On 12/1/09, Daniel Mack <daniel@caiaq.de> wrote:
>>> Hmm, I don't follow. You added some debug output and it started working,
>>> is that what you say? Do we possibly need memory barriers somewhere?
>>>
>>
>> Basically it, but I will do more tests to isolate the issue.
>>
>> In fact there is a board where the issue remain, but using old kernel
>> (2.6.22) both work.
> 
> I am also investigating this issue. The same happens sometimes with my 
> USB host with ULPI-ISP1504, but it never happens with the USB slave with 
> the exact same hardware ULPI-ISP1504, that's why I have the feeling that 
> it's a purely software issue.
> 
we once met a similar problem on i.MX27 : in fact, during IOMUX 
configuration, some pins were togled on the ULPI and the ISP1504 was 
taking this toggles as a command and was taking control of the ULPI bus 
which means the IMX wasn't anymore able to talk to it through ULPI. Just 
reseting the ISP1504 allawed the boot to continue fine.
Maybe your issue is similar to this.

Eric
