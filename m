From: carlo@caione.org (Carlo Caione)
Date: Fri, 16 May 2014 09:40:31 +0200
Subject: [linux-sunxi] Re: [PATCH v4 6/9] regulator: AXP20x: Add support
 for regulators subsystem
In-Reply-To: <5375015A.10701@free-electrons.com>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-7-git-send-email-carlo@caione.org>
 <5375015A.10701@free-electrons.com>
Message-ID: <CAOQ7t2ZrO_yD2W1qtk8aqBD2At6ieW5kmFwAoLQ1EsY144gUkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 8:03 PM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:
> Hello Carlo,
>
> On 11/04/2014 11:38, Carlo Caione wrote:
>> AXP202 and AXP209 come with two synchronous step-down DC-DCs and five
>> LDOs. This patch introduces basic support for those regulators.
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>>  drivers/regulator/Kconfig            |   7 +
>>  drivers/regulator/Makefile           |   1 +
> [...]
>> +     if (!np)
>> +             return 0;
>> +
>> +     regulators = of_find_node_by_name(np, "regulators");
>
> I know I'm late, and this patch has already been applied, but shouldn't
> we use of_get_child_by_name instead of of_find_node_by_name.
> This might lead to wrong regulators node parsing if other regulators are
> defined in the DT after the axp20x node, because, AFAIK, this function
> searches for DT nodes defined after the specified np node, but not
> necessarely children of the np node.

Right. I'll prepare a fix. Feel free to submit a patch if you want.

Thank you,

-- 
Carlo Caione
