From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 9 Jul 2015 14:32:01 +0900
Subject: [PATCH 1/7] pinctrl: UniPhier: add UniPhier pinctrl core support
In-Reply-To: <1436387996.20619.54.camel@tiscali.nl>
References: <1436185763-4308-1-git-send-email-yamada.masahiro@socionext.com>
 <1436185763-4308-2-git-send-email-yamada.masahiro@socionext.com>
 <1436260472.20057.121.camel@tiscali.nl>
 <CAK7LNASnaN47cPHyyH-DTrF4pE4XqhgUdZLuOspuqHtKoDxmRQ@mail.gmail.com>
 <1436387996.20619.54.camel@tiscali.nl>
Message-ID: <CAK7LNARqsxrFhSEOiZw7TYSyFR8vhaZYcK6KbuG84mP2eM5NJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

2015-07-09 5:39 GMT+09:00 Paul Bolle <pebolle@tiscali.nl>:
> Hi Masahiro,
>
> On wo, 2015-07-08 at 14:01 +0900, Masahiro Yamada wrote:
>> Actually, most of pinctrl drivers are boolean, but most of them
>> conventionally have MODULE_AUTHOR, THIS_MODULE, etc.
>>
>> I do not think it looks so weird.  Thought?
>
> It's a rather common pattern, but I think it's an anti-pattern
> nevertheless. See the discussion that Shobhit Kumar, Paul Gortmaker, and
> I had starting in https://lkml.org/lkml/2015/6/20/63 .
>
> Please let me know if you're unconvinced by the arguments brought
> forward by both Pauls in that discussion.
>


After I read your references and thought a bit more,
I am now considering to change the bool into tristate.

Pinctrl drivers usually contain quite big pin tables, so
it sounds somewhat reasonable to make it loadable,
given that minimal pin-settings could be done in the boot-loader.
Actually, some of pinctrl drivers in the mainline are already tristate.

I will send v2 later with some other fixes I have noticed.


Is this OK with you?


-- 
Best Regards
Masahiro Yamada
