From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2018 17:52:46 +0200
Subject: [GIT PULL 2/2] arm64: stratix10: defconfig update for v4.17
In-Reply-To: <c2860375-961a-65c4-ff23-6a2c4485699b@kernel.org>
References: <1521834884-23795-1-git-send-email-dinguyen@kernel.org>
 <1521834884-23795-2-git-send-email-dinguyen@kernel.org>
 <CAK8P3a0TTKEsmMavojQQcFG4-Y3EiDNtavLV2QdyHjNXHTE2Lw@mail.gmail.com>
 <c2860375-961a-65c4-ff23-6a2c4485699b@kernel.org>
Message-ID: <CAK8P3a2tOZXYMHuPCLpoEPAxiofBtYX5S_YXgS76oZU37NutPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 4:14 PM, Dinh Nguyen <dinguyen@kernel.org> wrote:
>
>
> On 03/27/2018 08:31 AM, Arnd Bergmann wrote:
>> On Fri, Mar 23, 2018 at 8:54 PM, Dinh Nguyen <dinguyen@kernel.org> wrote:
>>
>>> ----------------------------------------------------------------
>>> ARM64: stratix10: defconfig updates for 4.17
>>> -enables STMMAC_ETH controller that is present on Stratix10
>>
>> I got a conflict against an earlier patch that enabled CONFIG_STMMAC_ETH=m
>> and kept that version, as I see no need to have it built-in, see below for the
>> merge conflict resolution.
>
> The Stratix10 SoC needs to use the stmmac ethernet driver if it the user
> wants to mount a filesystem over NFS. Is there a way to load the
> ethernet module during boot-up before trying to mount into a RFS?

Yes, most distros do this using an initramfs. How common is that use
case for you? If there is a reason why initramfs adds too much complexity
to your workflow, we could still add it, but the preferred way is to have as
many modules as possible.

      arnd
