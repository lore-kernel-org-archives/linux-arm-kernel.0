From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 20 Jun 2016 16:01:11 +0100
Subject: [RFC PATCH 0/2] scpi: Add SCPI framework to handle vendors
 variants
In-Reply-To: <5767C492.60201@baylibre.com>
References: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
 <57472450.4000709@arm.com> <574802AF.2080909@baylibre.com>
 <574BFA13.40009@baylibre.com> <5755AE78.4030104@arm.com>
 <5767C492.60201@baylibre.com>
Message-ID: <57680537.1080009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/06/16 11:25, Neil Armstrong wrote:
> On 06/06/2016 07:10 PM, Sudeep Holla wrote:

[...]

>>
>> Though this initial version of SCPI is not published, I am sure it is
>> almost same as v1.0 except that the CMD is not part of payload like
>> v1.0. In v1.0 it's part of payload and the mailbox is used just for
>> doorbell mechanism.
> I hoped it would be this simple, but it touches core defines and structure
> that will over complicate the current driver. (i.e. the CMD indexes that differs,
> the CMD size shift, the high and low priority redirection or struct ordering)
>

Ah ok, understood.

>> IMO, we can add some compatible to indicate the pre v1.0 protocol
>> and add the support to the existing driver itself. Let me know your
>> thoughts.
>>
>
> My proposal is :
> - add a registry layer but with only a single scpi instance (no mode OF involved, remove drivers changes)
> - add a scpi_legacy.c driver that only supports the old SCPI like Amlogic and Rockchip, and add a disclaimer for new developed SoCs
> - add your extension capability to handle Amlogic's and Rockchip's extended commands
>
> If you agree, I'll post a new patchset for review with these changes.
>

Yes that sounds better. Also post along with the users to make it easy 
to review even if they are not completely ready for upstream.

-- 
Regards,
Sudeep
