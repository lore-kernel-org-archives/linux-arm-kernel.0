From: maxime.coquelin-nonst@stericsson.com (Maxime Coquelin)
Date: Thu, 10 Mar 2011 14:36:27 +0100
Subject: [RFC PATCHv1 0/2] Export SoC info through sysfs
In-Reply-To: <20110310130527.GA2154@besouro.research.nokia.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<20110310130527.GA2154@besouro.research.nokia.com>
Message-ID: <4D78D3DB.90708@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

On 03/10/2011 02:05 PM, Eduardo Valentin wrote:
>
>> The first patch introduces the common part, which provides an interface to the platform to register its name, and exports platform-defined IDs to user-space.
>> The IDs strings can be provided in two ways: either with a pointer to the string, or by a callback returning the string.
> Do you mind refreshing my memory why we need two ways of providing data to these attributes?
> I mean, I think if we provide the attribute value during registration time should be enough
> and simpler.
>
> Unless you guys are talking about attributes with changes over the time, I don't really see
> the need for the callback there. At least from the original scope, I don't see any attributes
> which would be exported under soc info which would change over the time.
>
> Or am I missing something?


It would be simpler indeed. But I don't know what are other SoC vendors 
needs, does someone need to export a piece of information which may 
change at runtime? If we all agree that providing a string at 
registration is enough, I'll remove it.
