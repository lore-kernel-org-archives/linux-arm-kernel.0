From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Feb 2018 19:59:25 -0800
Subject: [PATCH v9 2/3] arm: dts: add Nuvoton NPCM750 device tree
In-Reply-To: <CACPK8XeOUrrGinU_fmnmn4atYm3Bs-xSoB2MqT0Yr-LytHt78Q@mail.gmail.com>
References: <20180205235757.246758-1-brendanhiggins@google.com>
 <20180205235757.246758-3-brendanhiggins@google.com>
 <CACPK8XdXOaPZ5i=qKns3=V87nhfY62PNr4kwH9xwVYxY0djo0g@mail.gmail.com>
 <CACPK8XeOUrrGinU_fmnmn4atYm3Bs-xSoB2MqT0Yr-LytHt78Q@mail.gmail.com>
Message-ID: <A86ACBBE-0825-482F-81BE-24B7CAED92CD@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On February 14, 2018 6:28:51 PM PST, Joel Stanley <joel@jms.id.au> wrote:
>On Tue, Feb 13, 2018 at 4:52 PM, Joel Stanley <joel@jms.id.au> wrote:
>> Hi Brendan,
>>
>> On Tue, Feb 6, 2018 at 10:27 AM, Brendan Higgins
>> <brendanhiggins@google.com> wrote:
>>> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
>>> specific device tree for the NPCM750 (Poleg) evaluation board.
>>>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
>>> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
>>> Tested-by: Avi Fishman <avifishman70@gmail.com>
>>
>> This looks well acked, reviewed and tested. How do you plan to have
>> the ARM SoC maintainers merge your patches?
>
>Following up on an IRC conversation with Brendan:
>
>The process is normally to create a git branch based on on -rc1, apply
>your patches, and send them to the ARM maintainers. You then push a
>signed tag to a repository somewhere, send a pull request (a git
>request-pull email, not a Github PR) and Arnd, Olof or one of the
>other maintainers will pull your tree some time before the next merge
>window opens.
>
>Arnd, do we have this documented somewhere for new maintainers to
>follow?

I would add a few things that we had to go through before for Broadcom SoCs:

- send your pull requests to arm at kernel.org and copy Arnd, Olof and Kevin

- you would want to get your PGP key signed by as many people as people as possible which should not be a problem if you are in an area with lots of kernel people like the Bay Area (which reminds me I should do that)

- if you are going to be reasonably active every cycle consider getting a kernel.org account to host your tree (we are still not doing that...)

- for future pull requests, you might want to break them into e.g: DTS, board/Kconfig, drivers, defconfig, maintainers file, and have as little dependencies between each branch to minimize merge conflicts

- build test and run test your changes against at least one other platform, e.g: QEMU to check for multiplatform issues

In case this is of any value, there is a script here that will automatically generate pull requests emails for you based on branches matching what was mentioned above, it will also take care of CC'ing the people involved in the different patches:

https://github.com/ffainelli/misc-scripts/blob/master/gen-pull.pl

It still requires you to create an appropriate tag for the pull requests, though I might semi-automate that in the future, at least spawn an editor and offer some guidance, based on commit messages as to what should be in the pull request email/tag.

HTH

-- 
Florian
