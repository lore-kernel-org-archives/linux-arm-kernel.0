From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 May 2012 14:59:37 -0600
Subject: Handling of modular boards
In-Reply-To: <20120504203857.49EAD206451@gemini.denx.de>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <4FA432E9.9050606@wwwdotorg.org> <20120504203857.49EAD206451@gemini.denx.de>
Message-ID: <4FA44339.2010808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2012 02:38 PM, Wolfgang Denk wrote:
> Dear Stephen,
> 
> In message <4FA432E9.9050606@wwwdotorg.org> you wrote:
>>
>> representation of how to identify the child boards, and then have the
>> kernel only use/parse certain chunks of the DT based on the ID results.
> 
> I expect that this will quickly cause problems, for example in those
> many cases where pins and peripheral functions are multiplexed, or
> usable for different purposes. I would not want to maintain a DT that
> has to describe all combinations used by some boards - in a way that
> does not cause conflicts on either of them.

With the DT pinctrl bindings, you can define the pinctrl configuration
required to interact with particular child boards in the DT chunk for
that child board. So, I think this would work out fine; you wouldn't
have to represent a huge maze/array of conditional pinctrl settings in
the main board file.
