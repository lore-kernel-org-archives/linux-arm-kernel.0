From: prasannatsmkumar@gmail.com (PrasannaKumar Muralidharan)
Date: Fri, 24 Mar 2017 15:30:56 +0530
Subject: [PATCH v2 2/5] crypto: stm32 - Support for STM32 CRC32 crypto
 module
In-Reply-To: <a6c05e57-bdcc-4396-4a72-4d1b2977b8e4@st.com>
References: <1490109211-4869-1-git-send-email-fabien.dessenne@st.com>
 <1490109211-4869-3-git-send-email-fabien.dessenne@st.com>
 <CANc+2y4w=HhB230CD4MfxhvFZ2vM7Wsphz0zawhr0nVDSkREzQ@mail.gmail.com>
 <a6c05e57-bdcc-4396-4a72-4d1b2977b8e4@st.com>
Message-ID: <CANc+2y4pZ9TOijOea5bkV35D2R+JunLGrTsuN7s2fWWU_hPQjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 March 2017 at 15:26, Fabien DESSENNE <fabien.dessenne@st.com> wrote:
> On 24/03/17 05:28, PrasannaKumar Muralidharan wrote:
>> On 21 March 2017 at 20:43, Fabien Dessenne <fabien.dessenne@st.com> wrote:
>>> This module registers a CRC32 ("Ethernet") and a CRC32C (Castagnoli)
>>> algorithm that make use of the STMicroelectronics STM32 crypto hardware.
>>>
>>> Theses algorithms are compatible with the little-endian generic ones.
>>> Both algorithms use ~0 as default seed (key).
>>> With CRC32C the output is xored with ~0.
>>>
>>> Using TCRYPT CRC32C speed test, this shows up to 900% speedup compared
>>> to the crc32c-generic algorithm.
>> Comparing with crc3c-generic alogrithm does not sound like a good
>> metric for someone who has to decide between hw crypto or not.
>> Wouldn't it be better if the comparison is between crc32 using NEON
>> with hw crypto module? It will help in choosing between hw crypto or
>> arch optimised crc routiene.
>
> The STM32 microcontrollers are based on ARM Cortex-M7 (or older core)
> that do not have NEON support.

I was not aware of the absence of NEON support. Sorry for the noise.
