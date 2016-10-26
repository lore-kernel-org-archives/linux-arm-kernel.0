From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 26 Oct 2016 19:53:48 +0300
Subject: Pinctrl nodes missing for USB
In-Reply-To: <CANAwSgQ=pp93tDAERQ1iaryY3_pVhTeun=RaTo9ws1UKtS1PhA@mail.gmail.com>
References: <CANAwSgQ=pp93tDAERQ1iaryY3_pVhTeun=RaTo9ws1UKtS1PhA@mail.gmail.com>
Message-ID: <20161026165348.GA5600@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 05:56:54PM +0530, Anand Moon wrote:
> Hi All,
> 
> I have tried to enable CONFIG_DEBUG_PINCTRL=y on Odroid XU4.
> Just to try to understand the feature.
> Is this feature suppoted for USB nodes.
> 
> Below is the output of failed to pase pinctrl for USB nodes via dts.

I do not see any question here...

Anyway the devices not instantiated from DT will have such warning and
USB devices are not present in DT, from obvious reasons... However what
surprises me is why pinctrl_dt_to_map() was called for USB devices?

Best regards,
Krzysztof

> 
> [   11.627809] samsung-pinctrl 13400000.pinctrl: request pin 39
> (gpx3-7) for gpx3:39
> [   11.726818] xhci-hcd xhci-hcd.2.auto: no of_node; not parsing pinctrl DT
> [   11.801452] usb usb3: no of_node; not parsing pinctrl DT
> [   11.805471] hub 3-0:1.0: no of_node; not parsing pinctrl DT
> [   11.883263] usb usb4: no of_node; not parsing pinctrl DT
> [   11.887362] hub 4-0:1.0: no of_node; not parsing pinctrl DT
> [   11.926683] xhci-hcd xhci-hcd.5.auto: no of_node; not parsing pinctrl DT
> [   11.999588] usb usb5: no of_node; not parsing pinctrl DT
> [   12.003208] hub 5-0:1.0: no of_node; not parsing pinctrl DT
> [   12.085100] usb usb6: no of_node; not parsing pinctrl DT
> [   12.088936] hub 6-0:1.0: no of_node; not parsing pinctrl DT
> [   12.491299] usb 3-1: no of_node; not parsing pinctrl DT
> [   12.528446] hub 3-1:1.0: no of_node; not parsing pinctrl DT
> [   12.555071] usb 4-1: no of_node; not parsing pinctrl DT
> [   12.611412] hub 4-1:1.0: no of_node; not parsing pinctrl DT
> [   13.020668] usb 4-1.1: no of_node; not parsing pinctrl DT
> [   13.081803] usb-storage 4-1.1:1.0: no of_node; not parsing pinctrl DT
> [   13.091721] usb 5-1: no of_node; not parsing pinctrl DT
> [   13.127124] r8152 5-1:2.0: no of_node; not parsing pinctrl DT
> [   13.208321] r8152 5-1:1.0: no of_node; not parsing pinctrl DT
> [   14.281196] sd 0:0:0:0: no of_node; not parsing pinctrl DT
> [   16.057197] usb 4-1.2: no of_node; not parsing pinctrl DT
> [   16.079507] usb-storage 4-1.2:1.0: no of_node; not parsing pinctrl DT
> [   17.236626] sd 1:0:0:0: no of_node; not parsing pinctrl DT
> [   17.612139] usbhid 2-1:1.0: no of_node; not parsing pinctrl DT
> [   17.625511] usbhid 2-1:1.1: no of_node; not parsing pinctrl DT
> [   17.755059] hid-generic 0003:24AE:1000.0001: no of_node; not
> parsing pinctrl DT
> [   17.933665] hid-generic 0003:24AE:1000.0002: no of_node; not
> parsing pinctrl DT
> [ 1009.259380] usb 4-1.2: no of_node; not parsing pinctrl DT
> [ 1009.267240] usb-storage 4-1.2:1.0: no of_node; not parsing pinctrl DT
> [ 1010.311832] sd 1:0:0:0: no of_node; not parsing pinctrl DT
> 
> 
> Below is the complete output of dmesg | grep pinctr
> -------------------------------------
> root at odroidcsh:/usr/src/odroidxu3-4.y-devel# dmesg | grep pinc
> [    1.704176] pinctrl core: initialized pinctrl subsystem
> [    1.716053] reg-dummy reg-dummy: no of_node; not parsing pinctrl DT
> [    2.221885] samsung-pinctrl 13400000.pinctrl: try to register 40 pins ...
> [    2.221925] pinctrl core: registered pin 0 (gpy7-0) on samsung-pinctrl
> [    2.222005] pinctrl core: registered pin 1 (gpy7-1) on samsung-pinctrl
> [    2.222041] pinctrl core: registered pin 2 (gpy7-2) on samsung-pinctrl
> [    2.222077] pinctrl core: registered pin 3 (gpy7-3) on samsung-pinctrl
> [    2.222113] pinctrl core: registered pin 4 (gpy7-4) on samsung-pinctrl
> [    2.222148] pinctrl core: registered pin 5 (gpy7-5) on samsung-pinctrl
> [    2.222183] pinctrl core: registered pin 6 (gpy7-6) on samsung-pinctrl
> [    2.222217] pinctrl core: registered pin 7 (gpy7-7) on samsung-pinctrl
> [    2.222275] pinctrl core: registered pin 8 (gpx0-0) on samsung-pinctrl
> [    2.222320] pinctrl core: registered pin 9 (gpx0-1) on samsung-pinctrl
> [    2.222364] pinctrl core: registered pin 10 (gpx0-2) on samsung-pinctrl
> [    2.222406] pinctrl core: registered pin 11 (gpx0-3) on samsung-pinctrl
> [    2.222449] pinctrl core: registered pin 12 (gpx0-4) on samsung-pinctrl
> [    2.222491] pinctrl core: registered pin 13 (gpx0-5) on samsung-pinctrl
> [    2.222532] pinctrl core: registered pin 14 (gpx0-6) on samsung-pinctrl
> [    2.222573] pinctrl core: registered pin 15 (gpx0-7) on samsung-pinctrl
> [    2.222614] pinctrl core: registered pin 16 (gpx1-0) on samsung-pinctrl
> [    2.222653] pinctrl core: registered pin 17 (gpx1-1) on samsung-pinctrl
> [    2.222693] pinctrl core: registered pin 18 (gpx1-2) on samsung-pinctrl
> [    2.222732] pinctrl core: registered pin 19 (gpx1-3) on samsung-pinctrl
> [    2.222771] pinctrl core: registered pin 20 (gpx1-4) on samsung-pinctrl
> [    2.222809] pinctrl core: registered pin 21 (gpx1-5) on samsung-pinctrl
> [    2.222847] pinctrl core: registered pin 22 (gpx1-6) on samsung-pinctrl
> [    2.222885] pinctrl core: registered pin 23 (gpx1-7) on samsung-pinctrl
> [    2.222922] pinctrl core: registered pin 24 (gpx2-0) on samsung-pinctrl
> [    2.222958] pinctrl core: registered pin 25 (gpx2-1) on samsung-pinctrl
> [    2.222994] pinctrl core: registered pin 26 (gpx2-2) on samsung-pinctrl
> [    2.223030] pinctrl core: registered pin 27 (gpx2-3) on samsung-pinctrl
> [    2.223065] pinctrl core: registered pin 28 (gpx2-4) on samsung-pinctrl
> [    2.223100] pinctrl core: registered pin 29 (gpx2-5) on samsung-pinctrl
> [    2.223134] pinctrl core: registered pin 30 (gpx2-6) on samsung-pinctrl
> [    2.223168] pinctrl core: registered pin 31 (gpx2-7) on samsung-pinctrl
> [    2.223202] pinctrl core: registered pin 32 (gpx3-0) on samsung-pinctrl
> [    2.223258] pinctrl core: registered pin 33 (gpx3-1) on samsung-pinctrl
> [    2.223302] pinctrl core: registered pin 34 (gpx3-2) on samsung-pinctrl
> [    2.223345] pinctrl core: registered pin 35 (gpx3-3) on samsung-pinctrl
> [    2.223388] pinctrl core: registered pin 36 (gpx3-4) on samsung-pinctrl
> [    2.223430] pinctrl core: registered pin 37 (gpx3-5) on samsung-pinctrl
> [    2.223471] pinctrl core: registered pin 38 (gpx3-6) on samsung-pinctrl
> [    2.223512] pinctrl core: registered pin 39 (gpx3-7) on samsung-pinctrl
> [    2.324367] samsung-pinctrl 13410000.pinctrl: try to register 85 pins ...
> [    2.324441] pinctrl core: registered pin 40 (gpc0-0) on samsung-pinctrl
> [    2.324501] pinctrl core: registered pin 41 (gpc0-1) on samsung-pinctrl
> [    2.324547] pinctrl core: registered pin 42 (gpc0-2) on samsung-pinctrl
> [    2.324591] pinctrl core: registered pin 43 (gpc0-3) on samsung-pinctrl
> [    2.324634] pinctrl core: registered pin 44 (gpc0-4) on samsung-pinctrl
> [    2.324676] pinctrl core: registered pin 45 (gpc0-5) on samsung-pinctrl
> [    2.324718] pinctrl core: registered pin 46 (gpc0-6) on samsung-pinctrl
> [    2.324760] pinctrl core: registered pin 47 (gpc0-7) on samsung-pinctrl
> [    2.324801] pinctrl core: registered pin 48 (gpc1-0) on samsung-pinctrl
> [    2.324841] pinctrl core: registered pin 49 (gpc1-1) on samsung-pinctrl
> [    2.324881] pinctrl core: registered pin 50 (gpc1-2) on samsung-pinctrl
> [    2.324921] pinctrl core: registered pin 51 (gpc1-3) on samsung-pinctrl
> [    2.324960] pinctrl core: registered pin 52 (gpc1-4) on samsung-pinctrl
> [    2.324999] pinctrl core: registered pin 53 (gpc1-5) on samsung-pinctrl
> [    2.325038] pinctrl core: registered pin 54 (gpc1-6) on samsung-pinctrl
> [    2.325076] pinctrl core: registered pin 55 (gpc1-7) on samsung-pinctrl
> [    2.325113] pinctrl core: registered pin 56 (gpc2-0) on samsung-pinctrl
> [    2.325151] pinctrl core: registered pin 57 (gpc2-1) on samsung-pinctrl
> [    2.325187] pinctrl core: registered pin 58 (gpc2-2) on samsung-pinctrl
> [    2.325224] pinctrl core: registered pin 59 (gpc2-3) on samsung-pinctrl
> [    2.325259] pinctrl core: registered pin 60 (gpc2-4) on samsung-pinctrl
> [    2.325295] pinctrl core: registered pin 61 (gpc2-5) on samsung-pinctrl
> [    2.325330] pinctrl core: registered pin 62 (gpc2-6) on samsung-pinctrl
> [    2.325365] pinctrl core: registered pin 63 (gpc3-0) on samsung-pinctrl
> [    2.325468] pinctrl core: registered pin 64 (gpc3-1) on samsung-pinctrl
> [    2.325503] pinctrl core: registered pin 65 (gpc3-2) on samsung-pinctrl
> [    2.325560] pinctrl core: registered pin 66 (gpc3-3) on samsung-pinctrl
> [    2.325604] pinctrl core: registered pin 67 (gpc4-0) on samsung-pinctrl
> [    2.325647] pinctrl core: registered pin 68 (gpc4-1) on samsung-pinctrl
> [    2.325795] pinctrl core: registered pin 69 (gpd1-0) on samsung-pinctrl
> [    2.325839] pinctrl core: registered pin 70 (gpd1-1) on samsung-pinctrl
> [    2.325881] pinctrl core: registered pin 71 (gpd1-2) on samsung-pinctrl
> [    2.325923] pinctrl core: registered pin 72 (gpd1-3) on samsung-pinctrl
> [    2.325963] pinctrl core: registered pin 73 (gpd1-4) on samsung-pinctrl
> [    2.326004] pinctrl core: registered pin 74 (gpd1-5) on samsung-pinctrl
> [    2.326044] pinctrl core: registered pin 75 (gpd1-6) on samsung-pinctrl
> [    2.326084] pinctrl core: registered pin 76 (gpd1-7) on samsung-pinctrl
> [    2.326123] pinctrl core: registered pin 77 (gpy0-0) on samsung-pinctrl
> [    2.326163] pinctrl core: registered pin 78 (gpy0-1) on samsung-pinctrl
> [    2.326201] pinctrl core: registered pin 79 (gpy0-2) on samsung-pinctrl
> [    2.326239] pinctrl core: registered pin 80 (gpy0-3) on samsung-pinctrl
> [    2.326277] pinctrl core: registered pin 81 (gpy0-4) on samsung-pinctrl
> [    2.326314] pinctrl core: registered pin 82 (gpy0-5) on samsung-pinctrl
> [    2.326351] pinctrl core: registered pin 83 (gpy1-0) on samsung-pinctrl
> [    2.326387] pinctrl core: registered pin 84 (gpy1-1) on samsung-pinctrl
> [    2.326423] pinctrl core: registered pin 85 (gpy1-2) on samsung-pinctrl
> [    2.326459] pinctrl core: registered pin 86 (gpy1-3) on samsung-pinctrl
> [    2.326493] pinctrl core: registered pin 87 (gpy2-0) on samsung-pinctrl
> [    2.326528] pinctrl core: registered pin 88 (gpy2-1) on samsung-pinctrl
> [    2.326562] pinctrl core: registered pin 89 (gpy2-2) on samsung-pinctrl
> [    2.326596] pinctrl core: registered pin 90 (gpy2-3) on samsung-pinctrl
> [    2.326653] pinctrl core: registered pin 91 (gpy2-4) on samsung-pinctrl
> [    2.326697] pinctrl core: registered pin 92 (gpy2-5) on samsung-pinctrl
> [    2.326740] pinctrl core: registered pin 93 (gpy3-0) on samsung-pinctrl
> [    2.326782] pinctrl core: registered pin 94 (gpy3-1) on samsung-pinctrl
> [    2.326824] pinctrl core: registered pin 95 (gpy3-2) on samsung-pinctrl
> [    2.326866] pinctrl core: registered pin 96 (gpy3-3) on samsung-pinctrl
> [    2.326908] pinctrl core: registered pin 97 (gpy3-4) on samsung-pinctrl
> [    2.326949] pinctrl core: registered pin 98 (gpy3-5) on samsung-pinctrl
> [    2.326990] pinctrl core: registered pin 99 (gpy3-6) on samsung-pinctrl
> [    2.327030] pinctrl core: registered pin 100 (gpy3-7) on samsung-pinctrl
> [    2.327070] pinctrl core: registered pin 101 (gpy4-0) on samsung-pinctrl
> [    2.327110] pinctrl core: registered pin 102 (gpy4-1) on samsung-pinctrl
> [    2.327148] pinctrl core: registered pin 103 (gpy4-2) on samsung-pinctrl
> [    2.327187] pinctrl core: registered pin 104 (gpy4-3) on samsung-pinctrl
> [    2.327225] pinctrl core: registered pin 105 (gpy4-4) on samsung-pinctrl
> [    2.327263] pinctrl core: registered pin 106 (gpy4-5) on samsung-pinctrl
> [    2.327300] pinctrl core: registered pin 107 (gpy4-6) on samsung-pinctrl
> [    2.327337] pinctrl core: registered pin 108 (gpy4-7) on samsung-pinctrl
> [    2.327373] pinctrl core: registered pin 109 (gpy5-0) on samsung-pinctrl
> [    2.327409] pinctrl core: registered pin 110 (gpy5-1) on samsung-pinctrl
> [    2.327445] pinctrl core: registered pin 111 (gpy5-2) on samsung-pinctrl
> [    2.327479] pinctrl core: registered pin 112 (gpy5-3) on samsung-pinctrl
> [    2.327514] pinctrl core: registered pin 113 (gpy5-4) on samsung-pinctrl
> [    2.327548] pinctrl core: registered pin 114 (gpy5-5) on samsung-pinctrl
> [    2.327583] pinctrl core: registered pin 115 (gpy5-6) on samsung-pinctrl
> [    2.327639] pinctrl core: registered pin 116 (gpy5-7) on samsung-pinctrl
> [    2.327683] pinctrl core: registered pin 117 (gpy6-0) on samsung-pinctrl
> [    2.327726] pinctrl core: registered pin 118 (gpy6-1) on samsung-pinctrl
> [    2.327769] pinctrl core: registered pin 119 (gpy6-2) on samsung-pinctrl
> [    2.327812] pinctrl core: registered pin 120 (gpy6-3) on samsung-pinctrl
> [    2.327853] pinctrl core: registered pin 121 (gpy6-4) on samsung-pinctrl
> [    2.327894] pinctrl core: registered pin 122 (gpy6-5) on samsung-pinctrl
> [    2.327935] pinctrl core: registered pin 123 (gpy6-6) on samsung-pinctrl
> [    2.327976] pinctrl core: registered pin 124 (gpy6-7) on samsung-pinctrl
> [    2.381195] samsung-pinctrl 14000000.pinctrl: try to register 46 pins ...
> [    2.381304] pinctrl core: registered pin 125 (gpe0-0) on samsung-pinctrl
> [    2.381343] pinctrl core: registered pin 126 (gpe0-1) on samsung-pinctrl
> [    2.381381] pinctrl core: registered pin 127 (gpe0-2) on samsung-pinctrl
> [    2.381452] pinctrl core: registered pin 128 (gpe0-3) on samsung-pinctrl
> [    2.381489] pinctrl core: registered pin 129 (gpe0-4) on samsung-pinctrl
> [    2.381526] pinctrl core: registered pin 130 (gpe0-5) on samsung-pinctrl
> [    2.381562] pinctrl core: registered pin 131 (gpe0-6) on samsung-pinctrl
> [    2.381597] pinctrl core: registered pin 132 (gpe0-7) on samsung-pinctrl
> [    2.381633] pinctrl core: registered pin 133 (gpe1-0) on samsung-pinctrl
> [    2.381668] pinctrl core: registered pin 134 (gpe1-1) on samsung-pinctrl
> [    2.381702] pinctrl core: registered pin 135 (gpf0-0) on samsung-pinctrl
> [    2.381737] pinctrl core: registered pin 136 (gpf0-1) on samsung-pinctrl
> [    2.381794] pinctrl core: registered pin 137 (gpf0-2) on samsung-pinctrl
> [    2.381838] pinctrl core: registered pin 138 (gpf0-3) on samsung-pinctrl
> [    2.381881] pinctrl core: registered pin 139 (gpf0-4) on samsung-pinctrl
> [    2.381923] pinctrl core: registered pin 140 (gpf0-5) on samsung-pinctrl
> [    2.381965] pinctrl core: registered pin 141 (gpf1-0) on samsung-pinctrl
> [    2.382006] pinctrl core: registered pin 142 (gpf1-1) on samsung-pinctrl
> [    2.382048] pinctrl core: registered pin 143 (gpf1-2) on samsung-pinctrl
> [    2.382089] pinctrl core: registered pin 144 (gpf1-3) on samsung-pinctrl
> [    2.382129] pinctrl core: registered pin 145 (gpf1-4) on samsung-pinctrl
> [    2.382169] pinctrl core: registered pin 146 (gpf1-5) on samsung-pinctrl
> [    2.382209] pinctrl core: registered pin 147 (gpf1-6) on samsung-pinctrl
> [    2.382248] pinctrl core: registered pin 148 (gpf1-7) on samsung-pinctrl
> [    2.382287] pinctrl core: registered pin 149 (gpg0-0) on samsung-pinctrl
> [    2.382326] pinctrl core: registered pin 150 (gpg0-1) on samsung-pinctrl
> [    2.382363] pinctrl core: registered pin 151 (gpg0-2) on samsung-pinctrl
> [    2.382400] pinctrl core: registered pin 152 (gpg0-3) on samsung-pinctrl
> [    2.382437] pinctrl core: registered pin 153 (gpg0-4) on samsung-pinctrl
> [    2.382473] pinctrl core: registered pin 154 (gpg0-5) on samsung-pinctrl
> [    2.382509] pinctrl core: registered pin 155 (gpg0-6) on samsung-pinctrl
> [    2.382544] pinctrl core: registered pin 156 (gpg0-7) on samsung-pinctrl
> [    2.382580] pinctrl core: registered pin 157 (gpg1-0) on samsung-pinctrl
> [    2.382614] pinctrl core: registered pin 158 (gpg1-1) on samsung-pinctrl
> [    2.382649] pinctrl core: registered pin 159 (gpg1-2) on samsung-pinctrl
> [    2.382683] pinctrl core: registered pin 160 (gpg1-3) on samsung-pinctrl
> [    2.382717] pinctrl core: registered pin 161 (gpg1-4) on samsung-pinctrl
> [    2.382774] pinctrl core: registered pin 162 (gpg1-5) on samsung-pinctrl
> [    2.382818] pinctrl core: registered pin 163 (gpg1-6) on samsung-pinctrl
> [    2.382861] pinctrl core: registered pin 164 (gpg1-7) on samsung-pinctrl
> [    2.382903] pinctrl core: registered pin 165 (gpg2-0) on samsung-pinctrl
> [    2.382945] pinctrl core: registered pin 166 (gpg2-1) on samsung-pinctrl
> [    2.382987] pinctrl core: registered pin 167 (gpj4-0) on samsung-pinctrl
> [    2.383027] pinctrl core: registered pin 168 (gpj4-1) on samsung-pinctrl
> [    2.383068] pinctrl core: registered pin 169 (gpj4-2) on samsung-pinctrl
> [    2.383108] pinctrl core: registered pin 170 (gpj4-3) on samsung-pinctrl
> [    2.443773] samsung-pinctrl 14010000.pinctrl: try to register 54 pins ...
> [    2.443876] pinctrl core: registered pin 171 (gpa0-0) on samsung-pinctrl
> [    2.443912] pinctrl core: registered pin 172 (gpa0-1) on samsung-pinctrl
> [    2.443948] pinctrl core: registered pin 173 (gpa0-2) on samsung-pinctrl
> [    2.443983] pinctrl core: registered pin 174 (gpa0-3) on samsung-pinctrl
> [    2.444041] pinctrl core: registered pin 175 (gpa0-4) on samsung-pinctrl
> [    2.444085] pinctrl core: registered pin 176 (gpa0-5) on samsung-pinctrl
> [    2.444129] pinctrl core: registered pin 177 (gpa0-6) on samsung-pinctrl
> [    2.444172] pinctrl core: registered pin 178 (gpa0-7) on samsung-pinctrl
> [    2.444213] pinctrl core: registered pin 179 (gpa1-0) on samsung-pinctrl
> [    2.444255] pinctrl core: registered pin 180 (gpa1-1) on samsung-pinctrl
> [    2.444297] pinctrl core: registered pin 181 (gpa1-2) on samsung-pinctrl
> [    2.444338] pinctrl core: registered pin 182 (gpa1-3) on samsung-pinctrl
> [    2.444379] pinctrl core: registered pin 183 (gpa1-4) on samsung-pinctrl
> [    2.444419] pinctrl core: registered pin 184 (gpa1-5) on samsung-pinctrl
> [    2.444458] pinctrl core: registered pin 185 (gpa2-0) on samsung-pinctrl
> [    2.444497] pinctrl core: registered pin 186 (gpa2-1) on samsung-pinctrl
> [    2.444536] pinctrl core: registered pin 187 (gpa2-2) on samsung-pinctrl
> [    2.444575] pinctrl core: registered pin 188 (gpa2-3) on samsung-pinctrl
> [    2.444612] pinctrl core: registered pin 189 (gpa2-4) on samsung-pinctrl
> [    2.444650] pinctrl core: registered pin 190 (gpa2-5) on samsung-pinctrl
> [    2.444687] pinctrl core: registered pin 191 (gpa2-6) on samsung-pinctrl
> [    2.444756] pinctrl core: registered pin 192 (gpa2-7) on samsung-pinctrl
> [    2.444792] pinctrl core: registered pin 193 (gpb0-0) on samsung-pinctrl
> [    2.444828] pinctrl core: registered pin 194 (gpb0-1) on samsung-pinctrl
> [    2.444864] pinctrl core: registered pin 195 (gpb0-2) on samsung-pinctrl
> [    2.444899] pinctrl core: registered pin 196 (gpb0-3) on samsung-pinctrl
> [    2.444934] pinctrl core: registered pin 197 (gpb0-4) on samsung-pinctrl
> [    2.444968] pinctrl core: registered pin 198 (gpb1-0) on samsung-pinctrl
> [    2.445002] pinctrl core: registered pin 199 (gpb1-1) on samsung-pinctrl
> [    2.445059] pinctrl core: registered pin 200 (gpb1-2) on samsung-pinctrl
> [    2.445102] pinctrl core: registered pin 201 (gpb1-3) on samsung-pinctrl
> [    2.445145] pinctrl core: registered pin 202 (gpb1-4) on samsung-pinctrl
> [    2.445188] pinctrl core: registered pin 203 (gpb2-0) on samsung-pinctrl
> [    2.445231] pinctrl core: registered pin 204 (gpb2-1) on samsung-pinctrl
> [    2.445273] pinctrl core: registered pin 205 (gpb2-2) on samsung-pinctrl
> [    2.445314] pinctrl core: registered pin 206 (gpb2-3) on samsung-pinctrl
> [    2.445355] pinctrl core: registered pin 207 (gpb3-0) on samsung-pinctrl
> [    2.445395] pinctrl core: registered pin 208 (gpb3-1) on samsung-pinctrl
> [    2.445435] pinctrl core: registered pin 209 (gpb3-2) on samsung-pinctrl
> [    2.445475] pinctrl core: registered pin 210 (gpb3-3) on samsung-pinctrl
> [    2.445514] pinctrl core: registered pin 211 (gpb3-4) on samsung-pinctrl
> [    2.445553] pinctrl core: registered pin 212 (gpb3-5) on samsung-pinctrl
> [    2.445591] pinctrl core: registered pin 213 (gpb3-6) on samsung-pinctrl
> [    2.445629] pinctrl core: registered pin 214 (gpb3-7) on samsung-pinctrl
> [    2.445766] pinctrl core: registered pin 215 (gpb4-0) on samsung-pinctrl
> [    2.445806] pinctrl core: registered pin 216 (gpb4-1) on samsung-pinctrl
> [    2.445843] pinctrl core: registered pin 217 (gph0-0) on samsung-pinctrl
> [    2.445879] pinctrl core: registered pin 218 (gph0-1) on samsung-pinctrl
> [    2.445915] pinctrl core: registered pin 219 (gph0-2) on samsung-pinctrl
> [    2.445950] pinctrl core: registered pin 220 (gph0-3) on samsung-pinctrl
> [    2.445985] pinctrl core: registered pin 221 (gph0-4) on samsung-pinctrl
> [    2.446019] pinctrl core: registered pin 222 (gph0-5) on samsung-pinctrl
> [    2.446053] pinctrl core: registered pin 223 (gph0-6) on samsung-pinctrl
> [    2.446088] pinctrl core: registered pin 224 (gph0-7) on samsung-pinctrl
> [    2.459704] samsung-pinctrl 3860000.pinctrl: try to register 7 pins ...
> [    2.459809] pinctrl core: registered pin 225 (gpz-0) on samsung-pinctrl
> [    2.459849] pinctrl core: registered pin 226 (gpz-1) on samsung-pinctrl
> [    2.459888] pinctrl core: registered pin 227 (gpz-2) on samsung-pinctrl
> [    2.459927] pinctrl core: registered pin 228 (gpz-3) on samsung-pinctrl
> [    2.459965] pinctrl core: registered pin 229 (gpz-4) on samsung-pinctrl
> [    2.460003] pinctrl core: registered pin 230 (gpz-5) on samsung-pinctrl
> [    2.460040] pinctrl core: registered pin 231 (gpz-6) on samsung-pinctrl
> [    2.939603] pinctrl core: add 4 pinctrl maps
> [    2.939841] samsung-pinctrl 14010000.pinctrl: found group selector
> 6 for gpa0-6
> [    2.939894] samsung-pinctrl 14010000.pinctrl: found group selector
> 6 for gpa0-6
> [    2.939944] samsung-pinctrl 14010000.pinctrl: found group selector
> 7 for gpa0-7
> [    2.939992] samsung-pinctrl 14010000.pinctrl: found group selector
> 7 for gpa0-7
> [    2.940022] samsung-pinctrl 14010000.pinctrl: request pin 177
> (gpa0-6) for 12c80000.i2c
> [    2.940089] samsung-pinctrl 14010000.pinctrl: request pin 178
> (gpa0-7) for 12c80000.i2c
> [    2.941356] s3c-i2c 12c80000.i2c: obtain a copy of previously claimed pinctrl
> [    4.370371] alarmtimer alarmtimer: no of_node; not parsing pinctrl DT
> [    5.154339] pinctrl core: add 2 pinctrl maps
> [    5.154682] pinctrl core: add 2 pinctrl maps
> [    5.154943] samsung-pinctrl 14010000.pinctrl: found group selector
> 32 for gpb2-0
> [    5.155011] samsung-pinctrl 14010000.pinctrl: found group selector
> 32 for gpb2-0
> [    5.155082] samsung-pinctrl 14010000.pinctrl: found group selector
> 34 for gpb2-2
> [    5.155148] samsung-pinctrl 14010000.pinctrl: found group selector
> 34 for gpb2-2
> [    5.155183] samsung-pinctrl 14010000.pinctrl: request pin 203
> (gpb2-0) for 12dd0000.pwm
> [    5.155224] samsung-pinctrl 14010000.pinctrl: request pin 205
> (gpb2-2) for 12dd0000.pwm
> [    6.901592] serial8250 serial8250: no of_node; not parsing pinctrl DT
> [    9.157724] pinctrl core: add 2 pinctrl maps
> [    9.157952] samsung-pinctrl 13400000.pinctrl: found group selector
> 39 for gpx3-7
> [    9.158011] samsung-pinctrl 13400000.pinctrl: found group selector
> 39 for gpx3-7
> [    9.158041] samsung-pinctrl 13400000.pinctrl: request pin 39
> (gpx3-7) for 14530000.hdmi
> [    9.158853] samsung-pinctrl 13400000.pinctrl: request pin 39
> (gpx3-7) for gpx3:39
> [    9.169059] exynos-drm exynos-drm: no of_node; not parsing pinctrl DT
> [    9.683767] usb usb1: no of_node; not parsing pinctrl DT
> [    9.688758] hub 1-0:1.0: no of_node; not parsing pinctrl DT
> [    9.854041] usb usb2: no of_node; not parsing pinctrl DT
> [    9.857966] hub 2-0:1.0: no of_node; not parsing pinctrl DT
> [    9.925566] pinctrl core: add 4 pinctrl maps
> [    9.925744] samsung-pinctrl 14010000.pinctrl: found group selector
> 14 for gpa2-0
> [    9.925992] samsung-pinctrl 14010000.pinctrl: found group selector
> 14 for gpa2-0
> [    9.926046] samsung-pinctrl 14010000.pinctrl: found group selector
> 15 for gpa2-1
> [    9.926092] samsung-pinctrl 14010000.pinctrl: found group selector
> 15 for gpa2-1
> [    9.926122] samsung-pinctrl 14010000.pinctrl: request pin 185
> (gpa2-0) for 12ca0000.i2c
> [    9.926155] samsung-pinctrl 14010000.pinctrl: request pin 186
> (gpa2-1) for 12ca0000.i2c
> [    9.938344] pinctrl core: add 2 pinctrl maps
> [    9.938564] samsung-pinctrl 13400000.pinctrl: found group selector
> 12 for gpx0-4
> [    9.938620] samsung-pinctrl 13400000.pinctrl: found group selector
> 12 for gpx0-4
> [    9.938649] samsung-pinctrl 13400000.pinctrl: request pin 12
> (gpx0-4) for 4-0066
> [    9.951595] s2mps11-pmic s2mps11-regulator: no of_node; not parsing
> pinctrl DT
> [   10.354652] s5m-rtc s2mps14-rtc: no of_node; not parsing pinctrl DT
> [   10.358618] dummy 4-0006: no of_node; not parsing pinctrl DT
> [   10.391220] s2mps11-clk s2mps11-clk: no of_node; not parsing pinctrl DT
> [   10.504969] cpufreq-dt cpufreq-dt: no of_node; not parsing pinctrl DT
> [   10.605180] pinctrl core: add 2 pinctrl maps
> [   10.605286] samsung-pinctrl 13410000.pinctrl: found group selector
> 29 for gpd1-0
> [   10.605313] samsung-pinctrl 13410000.pinctrl: found group selector
> 29 for gpd1-0
> [   10.605331] samsung-pinctrl 13410000.pinctrl: request pin 69
> (gpd1-0) for pwrseq
> [   10.605645] samsung-pinctrl 13410000.pinctrl: request pin 69
> (gpd1-0) for gpd1:69
> [   10.623242] pinctrl core: add 2 pinctrl maps
> [   10.623392] pinctrl core: add 2 pinctrl maps
> [   10.623536] pinctrl core: add 2 pinctrl maps
> [   10.623706] pinctrl core: add 6 pinctrl maps
> [   10.623878] pinctrl core: add 8 pinctrl maps
> [   10.624024] pinctrl core: add 2 pinctrl maps
> [   10.624174] pinctrl core: add 2 pinctrl maps
> [   10.624278] samsung-pinctrl 13410000.pinctrl: found group selector
> 0 for gpc0-0
> [   10.624307] samsung-pinctrl 13410000.pinctrl: found group selector
> 0 for gpc0-0
> [   10.624335] samsung-pinctrl 13410000.pinctrl: found group selector
> 1 for gpc0-1
> [   10.624362] samsung-pinctrl 13410000.pinctrl: found group selector
> 1 for gpc0-1
> [   10.624389] samsung-pinctrl 13410000.pinctrl: found group selector
> 3 for gpc0-3
> [   10.624415] samsung-pinctrl 13410000.pinctrl: found group selector
> 3 for gpc0-3
> [   10.624442] samsung-pinctrl 13410000.pinctrl: found group selector
> 4 for gpc0-4
> [   10.624467] samsung-pinctrl 13410000.pinctrl: found group selector
> 4 for gpc0-4
> [   10.624493] samsung-pinctrl 13410000.pinctrl: found group selector
> 5 for gpc0-5
> [   10.624518] samsung-pinctrl 13410000.pinctrl: found group selector
> 5 for gpc0-5
> [   10.624543] samsung-pinctrl 13410000.pinctrl: found group selector
> 6 for gpc0-6
> [   10.624568] samsung-pinctrl 13410000.pinctrl: found group selector
> 6 for gpc0-6
> [   10.624594] samsung-pinctrl 13410000.pinctrl: found group selector
> 23 for gpc3-0
> [   10.624619] samsung-pinctrl 13410000.pinctrl: found group selector
> 23 for gpc3-0
> [   10.624644] samsung-pinctrl 13410000.pinctrl: found group selector
> 24 for gpc3-1
> [   10.624668] samsung-pinctrl 13410000.pinctrl: found group selector
> 24 for gpc3-1
> [   10.624693] samsung-pinctrl 13410000.pinctrl: found group selector
> 25 for gpc3-2
> [   10.624717] samsung-pinctrl 13410000.pinctrl: found group selector
> 25 for gpc3-2
> [   10.624755] samsung-pinctrl 13410000.pinctrl: found group selector
> 26 for gpc3-3
> [   10.624785] samsung-pinctrl 13410000.pinctrl: found group selector
> 26 for gpc3-3
> [   10.624815] samsung-pinctrl 13410000.pinctrl: found group selector
> 2 for gpc0-2
> [   10.624843] samsung-pinctrl 13410000.pinctrl: found group selector
> 2 for gpc0-2
> [   10.624873] samsung-pinctrl 13410000.pinctrl: found group selector
> 7 for gpc0-7
> [   10.624901] samsung-pinctrl 13410000.pinctrl: found group selector
> 7 for gpc0-7
> [   10.624917] samsung-pinctrl 13410000.pinctrl: request pin 40
> (gpc0-0) for 12200000.mmc
> [   10.624936] samsung-pinctrl 13410000.pinctrl: request pin 41
> (gpc0-1) for 12200000.mmc
> [   10.624954] samsung-pinctrl 13410000.pinctrl: request pin 43
> (gpc0-3) for 12200000.mmc
> [   10.624972] samsung-pinctrl 13410000.pinctrl: request pin 44
> (gpc0-4) for 12200000.mmc
> [   10.624990] samsung-pinctrl 13410000.pinctrl: request pin 45
> (gpc0-5) for 12200000.mmc
> [   10.625007] samsung-pinctrl 13410000.pinctrl: request pin 46
> (gpc0-6) for 12200000.mmc
> [   10.625025] samsung-pinctrl 13410000.pinctrl: request pin 63
> (gpc3-0) for 12200000.mmc
> [   10.625043] samsung-pinctrl 13410000.pinctrl: request pin 64
> (gpc3-1) for 12200000.mmc
> [   10.625061] samsung-pinctrl 13410000.pinctrl: request pin 65
> (gpc3-2) for 12200000.mmc
> [   10.625078] samsung-pinctrl 13410000.pinctrl: request pin 66
> (gpc3-3) for 12200000.mmc
> [   10.625095] samsung-pinctrl 13410000.pinctrl: request pin 42
> (gpc0-2) for 12200000.mmc
> [   10.625113] samsung-pinctrl 13410000.pinctrl: request pin 47
> (gpc0-7) for 12200000.mmc
> [   10.654376] samsung-pinctrl 13410000.pinctrl: request pin 42
> (gpc0-2) for gpc0:42
> [   10.734790] pinctrl core: add 2 pinctrl maps
> [   10.735262] pinctrl core: add 2 pinctrl maps
> [   10.736085] pinctrl core: add 2 pinctrl maps
> [   10.736604] pinctrl core: add 2 pinctrl maps
> [   10.737220] pinctrl core: add 6 pinctrl maps
> [   10.737601] samsung-pinctrl 13410000.pinctrl: found group selector
> 16 for gpc2-0
> [   10.737699] samsung-pinctrl 13410000.pinctrl: found group selector
> 16 for gpc2-0
> [   10.737803] samsung-pinctrl 13410000.pinctrl: found group selector
> 17 for gpc2-1
> [   10.737899] samsung-pinctrl 13410000.pinctrl: found group selector
> 17 for gpc2-1
> [   10.738001] samsung-pinctrl 13410000.pinctrl: found group selector
> 18 for gpc2-2
> [   10.738095] samsung-pinctrl 13410000.pinctrl: found group selector
> 18 for gpc2-2
> [   10.738196] samsung-pinctrl 13410000.pinctrl: found group selector
> 19 for gpc2-3
> [   10.738289] samsung-pinctrl 13410000.pinctrl: found group selector
> 19 for gpc2-3
> [   10.738389] samsung-pinctrl 13410000.pinctrl: found group selector
> 20 for gpc2-4
> [   10.738481] samsung-pinctrl 13410000.pinctrl: found group selector
> 20 for gpc2-4
> [   10.738642] samsung-pinctrl 13410000.pinctrl: found group selector
> 21 for gpc2-5
> [   10.738749] samsung-pinctrl 13410000.pinctrl: found group selector
> 21 for gpc2-5
> [   10.738863] samsung-pinctrl 13410000.pinctrl: found group selector
> 22 for gpc2-6
> [   10.738968] samsung-pinctrl 13410000.pinctrl: found group selector
> 22 for gpc2-6
> [   10.739022] samsung-pinctrl 13410000.pinctrl: request pin 56
> (gpc2-0) for 12220000.mmc
> [   10.739078] samsung-pinctrl 13410000.pinctrl: request pin 57
> (gpc2-1) for 12220000.mmc
> [   10.739127] samsung-pinctrl 13410000.pinctrl: request pin 58
> (gpc2-2) for 12220000.mmc
> [   10.739175] samsung-pinctrl 13410000.pinctrl: request pin 59
> (gpc2-3) for 12220000.mmc
> [   10.739224] samsung-pinctrl 13410000.pinctrl: request pin 60
> (gpc2-4) for 12220000.mmc
> [   10.739272] samsung-pinctrl 13410000.pinctrl: request pin 61
> (gpc2-5) for 12220000.mmc
> [   10.739320] samsung-pinctrl 13410000.pinctrl: request pin 62
> (gpc2-6) for 12220000.mmc
> [   10.923667] mmcblk mmc1:0007: no of_node; not parsing pinctrl DT
> [   11.140046] snd-soc-dummy snd-soc-dummy: no of_node; not parsing pinctrl DT
> [   11.220467] usb 2-1: no of_node; not parsing pinctrl DT
> [   11.626518] pinctrl core: add 2 pinctrl maps
> [   11.626743] samsung-pinctrl 13400000.pinctrl: found group selector
> 39 for gpx3-7
> [   11.626793] samsung-pinctrl 13400000.pinctrl: found group selector
> 39 for gpx3-7
> [   11.626820] samsung-pinctrl 13400000.pinctrl: request pin 39
> (gpx3-7) for 14530000.hdmi
> [   11.627809] samsung-pinctrl 13400000.pinctrl: request pin 39
> (gpx3-7) for gpx3:39
> [   11.726818] xhci-hcd xhci-hcd.2.auto: no of_node; not parsing pinctrl DT
> [   11.801452] usb usb3: no of_node; not parsing pinctrl DT
> [   11.805471] hub 3-0:1.0: no of_node; not parsing pinctrl DT
> [   11.883263] usb usb4: no of_node; not parsing pinctrl DT
> [   11.887362] hub 4-0:1.0: no of_node; not parsing pinctrl DT
> [   11.926683] xhci-hcd xhci-hcd.5.auto: no of_node; not parsing pinctrl DT
> [   11.999588] usb usb5: no of_node; not parsing pinctrl DT
> [   12.003208] hub 5-0:1.0: no of_node; not parsing pinctrl DT
> [   12.085100] usb usb6: no of_node; not parsing pinctrl DT
> [   12.088936] hub 6-0:1.0: no of_node; not parsing pinctrl DT
> [   12.491299] usb 3-1: no of_node; not parsing pinctrl DT
> [   12.528446] hub 3-1:1.0: no of_node; not parsing pinctrl DT
> [   12.555071] usb 4-1: no of_node; not parsing pinctrl DT
> [   12.611412] hub 4-1:1.0: no of_node; not parsing pinctrl DT
> [   13.020668] usb 4-1.1: no of_node; not parsing pinctrl DT
> [   13.081803] usb-storage 4-1.1:1.0: no of_node; not parsing pinctrl DT
> [   13.091721] usb 5-1: no of_node; not parsing pinctrl DT
> [   13.127124] r8152 5-1:2.0: no of_node; not parsing pinctrl DT
> [   13.208321] r8152 5-1:1.0: no of_node; not parsing pinctrl DT
> [   14.281196] sd 0:0:0:0: no of_node; not parsing pinctrl DT
> [   16.057197] usb 4-1.2: no of_node; not parsing pinctrl DT
> [   16.079507] usb-storage 4-1.2:1.0: no of_node; not parsing pinctrl DT
> [   17.236626] sd 1:0:0:0: no of_node; not parsing pinctrl DT
> [   17.612139] usbhid 2-1:1.0: no of_node; not parsing pinctrl DT
> [   17.625511] usbhid 2-1:1.1: no of_node; not parsing pinctrl DT
> [   17.755059] hid-generic 0003:24AE:1000.0001: no of_node; not
> parsing pinctrl DT
> [   17.933665] hid-generic 0003:24AE:1000.0002: no of_node; not
> parsing pinctrl DT
> [ 1009.259380] usb 4-1.2: no of_node; not parsing pinctrl DT
> [ 1009.267240] usb-storage 4-1.2:1.0: no of_node; not parsing pinctrl DT
> [ 1010.311832] sd 1:0:0:0: no of_node; not parsing pinctrl DT
> 
> Best Regards
> -Anand Moon
