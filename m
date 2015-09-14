From: songjun.wu@atmel.com (Wu, Songjun)
Date: Mon, 14 Sep 2015 14:34:02 +0800
Subject: [PATCH 1/2] ASoC: atmel-classd: add the Audio Class D Amplifier
 code
In-Reply-To: <20150911103417.GF12027@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-2-git-send-email-songjun.wu@atmel.com>
 <20150903113716.GU12027@sirena.org.uk> <55EC0AF5.8060403@atmel.com>
 <20150907162350.GV5313@sirena.org.uk> <55EEAC01.3080409@atmel.com>
 <20150908122322.GB9751@sirena.org.uk> <55EFA478.1000109@atmel.com>
 <20150909095245.GG9751@sirena.org.uk> <55F0EB68.9070800@atmel.com>
 <20150911103417.GF12027@sirena.org.uk>
Message-ID: <55F66A5A.7010502@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/11/2015 18:34, Mark Brown wrote:
> On Thu, Sep 10, 2015 at 10:31:04AM +0800, Wu, Songjun wrote:
>> On 9/9/2015 17:52, Mark Brown wrote:
>
>>> Yes, that's what's going to end up happening but it's not how controls
>>> are expected to behave - applications will expect changing one control
>>> to leave others unaffected so it's better to return an error rather than
>>> change the other control.
>
>> If application change non EQ controls, the others will be unaffected. But
>> the classD IP can only supports one EQ control at once, these three EQ
>> controls point to the same register field, if application set a different EQ
>> control, the error occurs, there will be many errors, it's not very
>> reasonable to application. The best way I think is if application set one EQ
>> control, the other EQ controls will change to 0dB, it's also consistent with
>> fact.
>
> There's no really good solutions here - this is why my initial
> suggestion was to have a single enumerated control.
>
You are right, your suggestion is reasonable, to have a single 
enumerated control. The second version will be made and sent soon.
