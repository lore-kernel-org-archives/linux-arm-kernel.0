From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Feb 2013 10:08:16 -0700
Subject: [v3 0/6] ARM: tegra: convert device tree files to use CLK defines
In-Reply-To: <CAPnjgZ0Bkk0Ock5_WQxsni+qNMQnWURrLLqfNFVfKczN6OgLoQ@mail.gmail.com>
References: <1360917814-27236-1-git-send-email-hdoyu@nvidia.com>
 <CAPnjgZ0Bkk0Ock5_WQxsni+qNMQnWURrLLqfNFVfKczN6OgLoQ@mail.gmail.com>
Message-ID: <5123B180.5060106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2013 03:20 PM, Simon Glass wrote:
> Hi Hiroshi,
> 
> On Fri, Feb 15, 2013 at 12:43 AM, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
>> Hi,
>>
>> With new dtc+cpp feature, we could get rid of magic numbers in dts*
>> files. This patch replaces CLK IDs.
...
> I wonder what sort of error message do you get when you make a mistake
> in the .dts or one of the .dtsi includes? If cpp is handling the
> including, does dtc just see a single file,

It is.

> in which case are the line
> numbers printed with each error not much use? Or does dtc handle the
> #line directives?

cpp does generate #line directives, which dtc does know how to
interpret, so this should all work just fine. IIRC, I did test out this
aspect when adding #line support to dtc.
