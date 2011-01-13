From: eric@eukrea.com (=?ISO-8859-15?Q?Eric_B=E9nard?=)
Date: Thu, 13 Jan 2011 10:17:41 +0100
Subject: [PATCH] unbreak ehci-mxc on otg port of i.MX27
In-Reply-To: <20110113091229.GE12078@pengutronix.de>
References: <1294909575-32709-1-git-send-email-eric@eukrea.com>
	<20110113091229.GE12078@pengutronix.de>
Message-ID: <4D2EC335.4010300@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 13/01/2011 10:12, Sascha Hauer wrote:
>>
>>   	/* "dr" device has its own clock */
>> -	if (pdev->id == 0) {
>> +	if ((cpu_is_mx51())&  (pdev->id == 0)) {
>
> should be&&  and please remove the unnecessary braces around
> cpu_is_mx51(). Otherwise ok.
>
shame on me for the &, a wrong copy and paste from my working tree removed the 
second one, While I'm here does MX53 or MX50 need this ?

Eric
